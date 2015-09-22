Refinery::Plugin.register do |plugin|
  plugin.title = "Purchases"
  plugin.description = "Manage Purchases"
  plugin.version = 1.0
  plugin.activity = {
    :class => Purchase,
    :url_prefix => "edit",
    :title => 'product_id'
  }
end
