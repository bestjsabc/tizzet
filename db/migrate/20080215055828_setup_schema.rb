class SetupSchema < ActiveRecord::Migration
  def self.up
    create_table "images" do |t|
      t.integer  "parent_id"
      t.string   "content_type"
      t.string   "filename"
      t.string   "thumbnail"
      t.integer  "size"
      t.integer  "width"
      t.integer  "height"
      t.string   "image_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "images", ["parent_id"], :name => "index_images_on_parent_id"

    create_table "page_parts" do |t|
      t.integer  "page_id"
      t.string   "title"
      t.text     "body"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "page_parts", ["id"], :name => "index_page_parts_on_id"
    add_index "page_parts", ["page_id"], :name => "index_page_parts_on_page_id"

    create_table "pages" do |t|
      t.string   "title"
      t.integer  "parent_id"
      t.integer  "position"
      t.string   "path"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "meta_keywords"
      t.text     "meta_description"
      t.boolean  "show_in_menu",        :default => true
      t.string   "link_url"
      t.string   "menu_match"
      t.boolean  "deletable",           :default => true
      t.string   "custom_title"
      t.string   "custom_title_type",   :default => "none"
      t.boolean  "draft",               :default => false
      t.string   "browser_title"
      t.boolean  "skip_to_first_child", :default => false
    end

    add_index "pages", ["id"], :name => "index_pages_on_id"
    add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"

    create_table "refinery_settings" do |t|
      t.string   "name"
      t.text     "value"
      t.boolean  "destroyable", :default => true
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "refinery_settings", ["name"], :name => "index_refinery_settings_on_name"

    create_table "resources" do |t|
      t.string   "content_type"
      t.string   "filename"
      t.integer  "size"
      t.integer  "parent_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "sessions" do |t|
      t.string   "session_id", :null => false
      t.text     "data"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
    add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

    create_table "slugs" do |t|
      t.string   "name"
      t.integer  "sluggable_id"
      t.integer  "sequence",                     :default => 1, :null => false
      t.string   "sluggable_type", :limit => 40
      t.string   "scope",          :limit => 40
      t.datetime "created_at"
    end

    add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_name_and_sluggable_type_and_scope_and_sequence", :unique => true
    add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

    create_table "user_plugins" do |t|
      t.integer "user_id"
      t.string  "title"
      t.integer "position"
    end

    add_index "user_plugins", ["title"], :name => "index_user_plugins_on_title"
    add_index "user_plugins", ["user_id", "title"], :name => "index_unique_user_plugins", :unique => true

    create_table "users" do |t|
      t.string   "login"
      t.string   "email"
      t.string   "crypted_password",          :limit => 40
      t.string   "salt",                      :limit => 40
      t.string   "remember_token"
      t.datetime "remember_token_expires_at"
      t.string   "activation_code",           :limit => 40
      t.datetime "activated_at"
      t.string   "state",                                   :default => "passive"
      t.datetime "deleted_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "superuser",                               :default => false
      t.string   "reset_code"
    end

    add_index "users", ["id"], :name => "index_users_on_id"
    add_index "users", ["login"], :name => "index_users_on_login"
  end

  def self.down
    drop_table :users
    drop_table :user_plugins
    drop_table :slugs
    drop_table :sessions
    drop_table :resources
    drop_table :refinery_settings
    drop_table :images
    drop_table :page_parts
    drop_table :pages
  end
end
