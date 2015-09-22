module UserRefinery
  def self.included(recipient)
    recipient.class_eval do
      serialize :plugins_column # Array # this is seriously deprecated and will be removed later.
      has_many :plugins, :class_name => "::UserPlugin", :order => "position ASC"
      def plugins=(plugin_titles)
        unless self.new_record? # don't add plugins when the user_id is NULL.
          self.plugins.delete_all

          plugin_titles.each do |plugin_title|
            self.plugins.find_or_create_by_title(plugin_title) if plugin_title.is_a?(String)
          end
        end
      end

      def authorized_plugins
        self.plugins.collect {|p| p.title} | Refinery::Plugins.always_allowed.titles
      end

      def ui_deletable?(current_user = self)
        !self.superuser and User.count > 1 and (current_user.nil? or self.id != current_user.id)
      end
    end
  end
end