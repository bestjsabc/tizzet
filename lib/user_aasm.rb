module UserAasm
  def self.included(recipient)
    recipient.class_eval do
      # Hack: Allow "rake gems:install" to run when this class is missing its gem dependency.
      # For further clarification on why, refer to:
      # https://rails.lighthouseapp.com/projects/8994/tickets/780-rake-gems-install-doesn-t-work-if-plugins-are-missing-gem-dependencies
      if defined? AASM
        include AASM # include the library which will give us state machine functionality.
        aasm_column :state
        aasm_initial_state :pending
        aasm_state :passive
        aasm_state :pending, :enter => :make_activation_code
        aasm_state :active,  :enter => :do_activate

        aasm_event :register do
          transitions :from => :passive, :to => :pending, :guard => Proc.new {|u| !(u.crypted_password.blank? && u.password.blank?) }
        end

        aasm_event :activate do
          transitions :from => :pending, :to => :active
        end
      end
    end
  end
end