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

ActiveRecord::Schema.define(:version => 20110406080025) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id",  :default => 0
  end

  create_table "cfgs", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_files", :force => true do |t|
    t.integer  "document_id", :null => false
    t.integer  "filelist_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.boolean  "published",    :default => false
    t.boolean  "approved",     :default => false
    t.integer  "hits",         :default => 0
    t.string   "description"
    t.integer  "access_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
  end

  create_table "filelists", :force => true do |t|
    t.string   "f_file_name"
    t.string   "f_content_type"
    t.integer  "f_file_size"
    t.datetime "f_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memos", :force => true do |t|
    t.text     "memo"
    t.integer  "object_id"
    t.string   "identify"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_contents", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.string   "position"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usergroups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",               :default => "",    :null => false
    t.string   "email",               :default => "",    :null => false
    t.string   "crypted_password",    :default => "",    :null => false
    t.string   "password_salt",       :default => "",    :null => false
    t.string   "persistence_token",   :default => "",    :null => false
    t.string   "single_access_token", :default => "",    :null => false
    t.string   "perishable_token",    :default => "",    :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "usergroup_id",        :default => 2
    t.integer  "rule_id"
    t.boolean  "access",              :default => false
  end

end
