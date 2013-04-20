# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130419024307) do

  create_table "articles", :force => true do |t|
    t.string   "title",                      :null => false
    t.text     "content",                    :null => false
    t.integer  "view_num",    :default => 0, :null => false
    t.integer  "comment_num", :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "user_id",                    :null => false
  end

  add_index "articles", ["user_id"], :name => "fk_articles_users"

  create_table "comments", :force => true do |t|
    t.text     "content",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "article_id", :null => false
  end

  add_index "comments", ["article_id"], :name => "fk_comments_articles"
  add_index "comments", ["user_id"], :name => "fk_comments_users"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "article_id"
  end

  add_index "tags", ["article_id"], :name => "fk_tags_articles"
  add_index "tags", ["user_id"], :name => "fk_tags_users"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "pwd"
    t.string   "email"
    t.string   "about"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_foreign_key "articles", "users", :name => "fk_articles_users"

  add_foreign_key "comments", "articles", :name => "fk_comments_articles"
  add_foreign_key "comments", "users", :name => "fk_comments_users"

  add_foreign_key "tags", "articles", :name => "fk_tags_articles"
  add_foreign_key "tags", "users", :name => "fk_tags_users"

end
