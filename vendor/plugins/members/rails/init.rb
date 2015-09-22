Refinery::Plugin.register do |plugin|
  plugin.title = "Members"
  plugin.description = "Manage Members"
  plugin.version = 1.0
  plugin.activity = {
    :class => Member,
    :url_prefix => "edit",
    :title => 'email'
  }
end
