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

ActiveRecord::Schema.define(:version => 20100501133926) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "emailalerts", :force => true do |t|
    t.integer  "system_id",                  :null => false
    t.text     "title",                      :null => false
    t.text     "body",                       :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.datetime "send_at",                    :null => false
    t.string   "status",     :default => "", :null => false
  end

  add_index "emailalerts", ["send_at"], :name => "send_at"
  add_index "emailalerts", ["system_id", "send_at"], :name => "system_id"

  create_table "profiles", :id => false, :force => true do |t|
    t.integer  "id",             :null => false
    t.integer  "user_id",        :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "blog"
    t.string   "covestor"
    t.string   "stocktwits"
    t.string   "kaching"
    t.text     "personal_blurb"
    t.text     "style_blurb"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "smsalerts", :force => true do |t|
    t.integer  "system_id",                  :null => false
    t.text     "message",                    :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.datetime "send_at",                    :null => false
    t.string   "status",     :default => "", :null => false
  end

  add_index "smsalerts", ["created_at"], :name => "created_at"
  add_index "smsalerts", ["send_at"], :name => "send_at"
  add_index "smsalerts", ["status"], :name => "status"

  create_table "subscriptions", :force => true do |t|
    t.integer  "system_id",                                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     :limit => 64, :default => "", :null => false
    t.string   "to_email",                 :default => "", :null => false
    t.string   "to_sms",                   :default => "", :null => false
    t.integer  "user_id",                                  :null => false
  end

  add_index "subscriptions", ["system_id"], :name => "system_id"
  add_index "subscriptions", ["user_id"], :name => "user_id"

  create_table "systems", :force => true do |t|
    t.integer  "user_id",                                                         :null => false
    t.string   "name"
    t.text     "description"
    t.integer  "price_email",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "price_sms",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "frequency_expected"
    t.integer  "frequency_actual"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",         :default => false, :null => false
  end

end
