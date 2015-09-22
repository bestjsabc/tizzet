Refinery::Plugin.register do |plugin|
  plugin.title = "Mailing Lists"
  plugin.description = "Manage Mailing Lists"
  plugin.version = 1.0
  plugin.activity = {
    :class => MailingList,
    :url_prefix => "edit",
    :title => 'name'
  }
end
