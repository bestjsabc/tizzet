# Methods added to this helper will be available to all templates in the application.

# You can extend refinery with your own functions here and they will likely not get overriden in an update.
module ApplicationHelper


  
  include Refinery::ApplicationHelper # leave this line in to include all of Refinery's core helper methods.
  
  def product_status
    {1 => "Active", 2 => 'Sold Out', 3 => 'Cancelled', 4 => 'Expired'}
  end
  
  def strip_html_tags(string)
    string.gsub(/<\/?[^>]*>/, "")
  end 

  def trim_description_length(string,length)
    unless string.nil?
      string = strip_html_tags(string)

      if(string.length > length)
        string[0,length] + "..."
      else
        string  
      end
    end
  end
  
end
