Refinery::Plugin.register do |plugin|
  plugin.title = "Landing Pages"
  plugin.description = "Manages Landing Pages"
  plugin.version = 1.0
  plugin.activity = {
    :class => LandingPage,
    :url_prefix => "edit",
    :title => 'title'
  }
end
