class MailingList < ActiveRecord::Base

  acts_as_indexed :fields => [:name, :email],
                  :index_file => [Rails.root.to_s, "tmp", "index"]

  validates_presence_of :name
  validates_presence_of :email, :on => :create, :message => "can't be blank"


end
