class LandingPage < ActiveRecord::Base
  
  # What is the max image size a user can upload
  MAX_SIZE_IN_MB = 20

  # Docs for attachment_fu http://github.com/technoweenie/attachment_fu
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :path_prefix => 'public/system/landing_pages',
                 :processor => 'Rmagick',
                 :thumbnails => ((((thumbnails = RefinerySetting.find_or_set(:image_thumbnails, {})).is_a?(Hash) ? thumbnails : (RefinerySetting[:image_thumbnails] = {}))) rescue {}),
                 :max_size => MAX_SIZE_IN_MB.megabytes

  # we could use validates_as_attachment but it produces 4 odd errors like
  # "size is not in list". So we basically here enforce the same validation
  # rules here except display the error messages we want
  # This is a known problem when using attachment_fu
  def validate
    if self.filename.nil?
      errors.add_to_base("You must choose an image to upload")
    else
      [:size, :content_type].each do |attr_name|
        enum = attachment_options[attr_name]

        unless enum.nil? || enum.include?(send(attr_name))
          errors.add_to_base("Images should be smaller than #{MAX_SIZE_IN_MB} MB in size") if attr_name == :size
          errors.add_to_base("Your image must be either a JPG, PNG or GIF") if attr_name == :content_type
        end
      end
    end
  end

  acts_as_indexed :fields => [:content_type, :filename, :thumbnail, :image_type],
                  :index_file => [Rails.root.to_s, "tmp", "index"]

  #validates_presence_of :product_id
  #validates_uniqueness_of :product_id
  
  named_scope :thumbnails, :conditions => "parent_id IS NOT NULL"
  named_scope :originals, :conditions => {:parent_id => nil}
  named_scope :public, :conditions => ["archived = ? OR archived IS NULL", false]
  
end