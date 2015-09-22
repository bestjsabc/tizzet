# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110412064248) do

  create_table "banners", :force => true do |t|
    t.integer  "product_id"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.string   "image_type"
    t.boolean  "archived"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banners", ["id"], :name => "index_banners_on_id"

  create_table "images", :force => true do |t|
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

  create_table "landing_pages", :force => true do |t|
    t.string  "title"
    t.text    "description"
    t.string  "filename"
    t.integer "position"
    t.string  "thumbnail"
    t.integer "size"
    t.integer "width"
    t.integer "height"
    t.integer "image_type"
    t.string  "content_type"
    t.integer "parent_id"
    t.string  "browser_title"
    t.string  "meta_keywords"
    t.text    "meta_description"
  end

  create_table "mailing_lists", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mailing_lists", ["id"], :name => "index_mailing_lists_on_id"

  create_table "members", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.string   "activation_code"
    t.datetime "activated_at"
    t.string   "title"
    t.text     "address"
    t.string   "city"
    t.integer  "post_code"
    t.string   "country"
    t.string   "day_phone"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.text     "referal"
    t.boolean  "agreement"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "territory_state"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "aus_bank_num"
    t.integer  "bsb_num"
    t.string   "bank"
    t.string   "paypal_account"
    t.string   "paypal_email"
  end

  add_index "members", ["id"], :name => "index_members_on_id"

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "ticket_id",          :default => -1, :null => false
    t.integer  "quantity",           :default => 1,  :null => false
    t.integer  "buyer_id",           :default => -1, :null => false
    t.string   "buyer_ip_address",   :default => "", :null => false
    t.integer  "amount_in_cents",    :default => 0,  :null => false
    t.string   "credit_card_suffix"
    t.string   "card_first_name"
    t.string   "card_last_name"
    t.datetime "shipped"
    t.datetime "contested"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tracking_number"
  end

  create_table "page_parts", :force => true do |t|
    t.integer  "page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_parts", ["id"], :name => "index_page_parts_on_id"
  add_index "page_parts", ["page_id"], :name => "index_page_parts_on_page_id"

  create_table "pages", :force => true do |t|
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

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "purchase_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "event_type"
    t.string   "host"
    t.string   "visitor"
    t.string   "event"
    t.string   "seating_type"
    t.boolean  "individual_sales"
    t.date     "date"
    t.string   "location"
    t.string   "state"
    t.integer  "seller_id"
    t.integer  "quantity"
    t.string   "territory_state"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_in_cents"
    t.integer  "quantity_on_hand"
    t.integer  "quantity_sold"
    t.date     "list_until"
    t.float    "price"
    t.boolean  "hot_ticket_pick",  :default => false
    t.integer  "status"
    t.time     "start_time"
    t.string   "seating_block"
    t.string   "seating_row"
    t.string   "seat_number"
  end

  add_index "products", ["id"], :name => "index_products_on_id"

  create_table "purchases", :force => true do |t|
    t.integer  "product_id"
    t.integer  "buyer_id"
    t.integer  "quantity"
    t.float    "price"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "post_code"
    t.string   "country"
    t.string   "day_phone"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.string   "card_first_name"
    t.string   "card_last_name"
    t.string   "card_type"
    t.string   "credit_card_number"
    t.integer  "expiry_month"
    t.integer  "expiry_year"
    t.integer  "verification_code"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_status"
    t.boolean  "received"
    t.string   "email"
    t.boolean  "seller_paid"
    t.string   "txn_id"
    t.string   "event"
    t.date     "date"
    t.time     "start_time"
    t.string   "seating_type"
    t.string   "seating_block"
    t.string   "seating_row"
    t.string   "seat_number"
    t.integer  "seller_id"
    t.string   "location"
  end

  add_index "purchases", ["id"], :name => "index_purchases_on_id"

  create_table "refinery_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "destroyable", :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_settings", ["name"], :name => "index_refinery_settings_on_name"

  create_table "resources", :force => true do |t|
    t.string   "content_type"
    t.string   "filename"
    t.integer  "size"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_name_and_sluggable_type_and_scope_and_sequence", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "tickets", :force => true do |t|
    t.string   "event_type",       :limit => 16,                            :null => false
    t.string   "host",             :limit => 30, :default => "",            :null => false
    t.string   "visitor",          :limit => 30, :default => "",            :null => false
    t.string   "event",            :limit => 30, :default => "",            :null => false
    t.string   "seating_type",     :limit => 11, :default => "Unallocated", :null => false
    t.boolean  "individual_sales",               :default => true,          :null => false
    t.date     "date",                                                      :null => false
    t.string   "location",         :limit => 60, :default => "",            :null => false
    t.string   "state",            :limit => 10, :default => "Available",   :null => false
    t.integer  "seller_id",                      :default => -1,            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",                       :default => 1,             :null => false
    t.integer  "price_in_cents"
    t.string   "territory_state"
  end

  create_table "user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "title"
    t.integer "position"
  end

  add_index "user_plugins", ["title"], :name => "index_user_plugins_on_title"
  add_index "user_plugins", ["user_id", "title"], :name => "index_unique_user_plugins", :unique => true

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "superuser",                                :default => false
    t.string   "reset_code"
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "title",                     :limit => 5
    t.text     "address"
    t.string   "city",                      :limit => 30
    t.integer  "post_code"
    t.string   "country",                   :limit => 50
    t.string   "day_phone",                 :limit => 20
    t.string   "home_phone",                :limit => 20
    t.string   "mobile_phone",              :limit => 20
    t.text     "referal"
    t.boolean  "agreement"
    t.string   "first_name",                :limit => 50
    t.string   "last_name",                 :limit => 50
    t.string   "territory_state",           :limit => 3
  end

  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["login"], :name => "index_users_on_login"

end
