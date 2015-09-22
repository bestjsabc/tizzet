module CustomEmailHelpers

  def first_link_in_email
    link = links_in_email(current_email).first
    request_uri = URI::parse(link).request_uri
  end
  
end
World(CustomEmailHelpers)