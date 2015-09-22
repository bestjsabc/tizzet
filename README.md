# RailsAdmin
[![Gem Version](https://badge.fury.io/rb/rails_admin.png)][gem]
[![Build Status](https://secure.travis-ci.org/sferik/rails_admin.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/sferik/rails_admin.png?travis)][gemnasium]
[![Code Climate](https://codeclimate.com/github/sferik/rails_admin.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/sferik/rails_admin/badge.png?branch=master)][coveralls]
[![Pledgie](http://www.pledgie.com/campaigns/15917.png)][pledgie]
[![Flattr](http://api.flattr.com/button/flattr-badge-large.png)][flattr]

[gem]: https://rubygems.org/gems/rails_admin
[travis]: http://travis-ci.org/sferik/rails_admin
[gemnasium]: https://gemnasium.com/sferik/rails_admin
[codeclimate]: https://codeclimate.com/github/sferik/rails_admin
[coveralls]: https://coveralls.io/r/sferik/rails_admin
[pledgie]: http://www.pledgie.com/campaigns/15917
[flattr]: http://flattr.com/thing/799416/sferikrailsadmin-on-GitHub

RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data.


## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby implementations:

* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0
* [Rubinius][]
* [JRuby][]

[rubinius]: http://rubini.us/
[jruby]: http://jruby.org/
	
## Demo
Take RailsAdmin for a [test drive][demo] with sample data. ([Source code.][dummy_app])

[demo]: http://rails-admin-tb.herokuapp.com/
[dummy_app]: https://github.com/bbenezech/dummy_app

## Installation
In your `Gemfile`, add the following dependencies:

    gem 'fastercsv' # Only required on Ruby 1.8 and below
    gem 'rails_admin'

Run:

    bundle install

And then run:

    rails g rails_admin:install

This generator will install RailsAdmin and [Devise](https://github.com/plataformatec/devise) if you
don't already have it installed. [Devise](https://github.com/plataformatec/devise) is strongly
recommended to protect your data from anonymous users. Note: If you do not already have [Devise](https://github.com/plataformatec/devise)
installed, make sure you remove the registerable module from the generated user model.

It will modify your `config/routes.rb`, adding:

```ruby
mount RailsAdmin::Engine => '/admin', :as => 'rails_admin' # Feel free to change '/admin' to any namespace you need.
```

Note: The `devise_for` route must be placed before the mounted engine. The following will generate infinite redirects.

```ruby
mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
devise_for :admins
```

This will resolve the infinite redirect error:

```ruby
devise_for :admins
mount RailsAdmin::Engine => '/rails_admin', :as => 'rails_admin'
```

See [#715](https://github.com/sferik/rails_admin/issues/715) for more details.

It will also add an intializer that will help you getting started. (head for config/initializers/rails_admin.rb)

Finally run:

    bundle exec rake db:migrate

Optionally, you may wish to set up [Cancan](https://github.com/ryanb/cancan),
[PaperTrail](https://github.com/airblade/paper_trail), [CKeditor](https://github.com/galetahub/ckeditor), [CodeMirror](https://github.com/fixlr/codemirror-rails)

More on that in the [Wiki](https://github.com/sferik/rails_admin/wiki)


## Configuration
All configuration documentation has moved to the wiki: https://github.com/sferik/rails_admin/wiki

## Screenshots
![Dashboard view](https://github.com/sferik/rails_admin/raw/master/screenshots/dashboard.png "dashboard view")
![Delete view](https://github.com/sferik/rails_admin/raw/master/screenshots/delete.png "delete view")
![List view](https://github.com/sferik/rails_admin/raw/master/screenshots/list.png "list view")
![Nested view](https://github.com/sferik/rails_admin/raw/master/screenshots/nested.png "nested view")
![Polymorphic edit view](https://github.com/sferik/rails_admin/raw/master/screenshots/polymorphic.png "polymorphic view")

## Support
If you have a question, please check this README, the wiki, and the [list of
known issues][troubleshoot].

[troubleshoot]: https://github.com/sferik/rails_admin/wiki/Troubleshoot

If you still have a question, you can ask the [official RailsAdmin mailing
list][list].

[list]: http://groups.google.com/group/rails_admin

If you think you found a bug in RailsAdmin, you can [submit an issue](https://github.com/sferik/rails_admin/issues/new).

## Usage
Start the server:

    rails server

You should now be able to administer your site at
[http://localhost:3000/admin](http://localhost:3000/admin).
