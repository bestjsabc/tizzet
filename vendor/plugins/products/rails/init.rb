Refinery::Plugin.register do |plugin|
  plugin.title = "Products"
  plugin.description = "Manage Products"
  plugin.version = 1.0
  plugin.activity = {
    :class => Product,
    :url_prefix => "edit",
    :title => 'event_type'
  }
end
