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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151130064739) do

  create_table "ad_clicks", force: :cascade do |t|
    t.integer  "ad_id",         limit: 4
    t.text     "customer_code", limit: 65535
    t.string   "ip",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "latitude",      limit: 255
    t.string   "longitude",     limit: 255
    t.string   "ip_address",    limit: 255
    t.string   "city",          limit: 255
    t.string   "zipcode",       limit: 255
    t.string   "country",       limit: 255
    t.integer  "pb_member_id",  limit: 4
  end

  create_table "ad_positions", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "title",         limit: 255
    t.text     "description",   limit: 65535
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.integer  "width",         limit: 4
    t.integer  "height",        limit: 4
    t.decimal  "click_price",                 precision: 10
    t.decimal  "day_price",                   precision: 10
    t.string   "style_name",    limit: 255
    t.integer  "number_of_ad",  limit: 4,                    default: 1
    t.integer  "display_order", limit: 4
  end

  create_table "ads", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.text     "description",          limit: 65535
    t.integer  "ad_position_id",       limit: 4
    t.text     "url",                  limit: 65535
    t.string   "image",                limit: 255
    t.integer  "user_id",              limit: 4
    t.string   "status",               limit: 255
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.integer  "pb_member_id",         limit: 4
    t.string   "type_name",            limit: 255
    t.integer  "pb_product_id",        limit: 4
    t.decimal  "max_budget",                         precision: 10
    t.integer  "days",                 limit: 4
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "payment_type",         limit: 255
    t.text     "nganluong_return_url", limit: 65535
    t.string   "image_2",              limit: 255
    t.string   "image_3",              limit: 255
    t.string   "image_4",              limit: 255
    t.text     "description_2",        limit: 65535
    t.decimal  "price",                              precision: 10
    t.decimal  "display_price",                      precision: 10
    t.string   "display_price_unit",   limit: 255
    t.integer  "active",               limit: 4,                    default: 0
    t.integer  "pb_industry_id",       limit: 4
  end

  create_table "email", force: :cascade do |t|
    t.string "email", limit: 100,  null: false
    t.string "name",  limit: 100,  null: false
    t.string "pic",   limit: 2000, null: false
  end

  create_table "pb_adcheckouts", force: :cascade do |t|
    t.integer  "ad_id",   limit: 4,     null: false
    t.datetime "created",               null: false
    t.integer  "months",  limit: 4,     null: false
    t.text     "amount",  limit: 65535, null: false
  end

  create_table "pb_adminfields", primary_key: "member_id", force: :cascade do |t|
    t.boolean "depart_id",                 default: false, null: false
    t.string  "first_name",  limit: 25,    default: "",    null: false
    t.string  "last_name",   limit: 25,    default: "",    null: false
    t.boolean "level",                     default: false, null: false
    t.integer "last_login",  limit: 4,     default: 0,     null: false
    t.string  "last_ip",     limit: 25,    default: "",    null: false
    t.integer "expired",     limit: 4,     default: 0,     null: false
    t.text    "permissions", limit: 65535,                 null: false
    t.integer "created",     limit: 4,     default: 0,     null: false
    t.integer "modified",    limit: 4,     default: 0,     null: false
  end

  create_table "pb_adminmodules", force: :cascade do |t|
    t.integer "parent_id", limit: 2,  default: 0,  null: false
    t.string  "name",      limit: 50, default: "", null: false
  end

  create_table "pb_adminnotes", force: :cascade do |t|
    t.integer "member_id", limit: 4,     default: 0,  null: false
    t.string  "title",     limit: 100,   default: "", null: false
    t.text    "content",   limit: 65535
    t.integer "created",   limit: 4,     default: 0,  null: false
    t.integer "modified",  limit: 4,     default: 0,  null: false
  end

  create_table "pb_adminprivileges", force: :cascade do |t|
    t.integer "adminmodule_id", limit: 4,  default: 0,  null: false
    t.string  "name",           limit: 25, default: "", null: false
  end

  create_table "pb_adminroles", force: :cascade do |t|
    t.string "name", limit: 25
  end

  create_table "pb_adses", force: :cascade do |t|
    t.integer "adzone_id",       limit: 2,     default: 0,        null: false
    t.string  "title",           limit: 50,    default: "",       null: false
    t.text    "description",     limit: 65535
    t.boolean "is_image",                      default: true,     null: false
    t.string  "source_name",     limit: 100,   default: "",       null: false
    t.string  "source_type",     limit: 100,   default: "",       null: false
    t.string  "source_url",      limit: 255,   default: "",       null: false
    t.string  "target_url",      limit: 255,   default: "",       null: false
    t.integer "width",           limit: 2,     default: 0,        null: false
    t.integer "height",          limit: 2,     default: 0,        null: false
    t.string  "alt_words",       limit: 25,    default: "",       null: false
    t.integer "start_date",      limit: 4,     default: 0,        null: false
    t.integer "end_date",        limit: 4,     default: 0,        null: false
    t.boolean "priority",                      default: false,    null: false
    t.integer "clicked",         limit: 2,     default: 1,        null: false
    t.string  "target",          limit: 7,     default: "_blank", null: false
    t.boolean "seq",                           default: false,    null: false
    t.boolean "state",                         default: true,     null: false
    t.boolean "status",                        default: false,    null: false
    t.string  "picture_replace", limit: 255,   default: "",       null: false
    t.integer "created",         limit: 4,     default: 0,        null: false
    t.integer "modified",        limit: 4,     default: 0,        null: false
    t.integer "member_id",       limit: 4
    t.integer "industry_id",     limit: 4
    t.text    "clicked_logs",    limit: 65535,                    null: false
    t.integer "display_order",   limit: 4,     default: 0,        null: false
    t.integer "company_id",      limit: 4,                        null: false
    t.integer "membergroup_id",  limit: 4,                        null: false
    t.text    "industries",      limit: 65535,                    null: false
    t.integer "adsize_id",       limit: 4,                        null: false
    t.text    "text_line1",      limit: 65535,                    null: false
    t.text    "text_line2",      limit: 65535,                    null: false
  end

  create_table "pb_adsizes", force: :cascade do |t|
    t.string  "name",   limit: 255, null: false
    t.integer "width",  limit: 4,   null: false
    t.integer "height", limit: 4,   null: false
  end

  create_table "pb_adzones", force: :cascade do |t|
    t.string  "membergroup_ids",    limit: 50,    default: "",    null: false
    t.string  "what",               limit: 10,    default: "",    null: false
    t.boolean "style",                            default: false, null: false
    t.string  "name",               limit: 100,   default: "",    null: false
    t.text    "description",        limit: 65535
    t.text    "additional_adwords", limit: 65535
    t.float   "price",              limit: 24,    default: 0.0,   null: false
    t.string  "file_name",          limit: 100,   default: "",    null: false
    t.integer "width",              limit: 2,     default: 0,     null: false
    t.integer "height",             limit: 2,     default: 0,     null: false
    t.integer "wrap",               limit: 2,     default: 0,     null: false
    t.integer "max_ad",             limit: 2,     default: 0,     null: false
    t.integer "created",            limit: 4,     default: 0,     null: false
    t.integer "modified",           limit: 4,     default: 0,     null: false
    t.integer "company_zone",       limit: 4,     default: 0,     null: false
    t.integer "display_order",      limit: 4,     default: 0,     null: false
  end

  create_table "pb_albums", force: :cascade do |t|
    t.integer "member_id",     limit: 4,   default: 0, null: false
    t.integer "attachment_id", limit: 4,   default: 0, null: false
    t.integer "type_id",       limit: 2,   default: 0, null: false
    t.string  "type",          limit: 255,             null: false
    t.integer "thumb_id",      limit: 4,               null: false
    t.integer "state",         limit: 4,   default: 1, null: false
  end

  create_table "pb_albumtypes", force: :cascade do |t|
    t.string  "name",          limit: 255, default: "",    null: false
    t.boolean "display_order",             default: false, null: false
  end

  create_table "pb_announcements", force: :cascade do |t|
    t.integer "announcetype_id",    limit: 2,     default: 0,     null: false
    t.string  "subject",            limit: 255,   default: "",    null: false
    t.text    "message",            limit: 65535
    t.boolean "display_order",                    default: false, null: false
    t.integer "display_expiration", limit: 4,     default: 0,     null: false
    t.integer "created",            limit: 4,     default: 0,     null: false
    t.integer "modified",           limit: 4,     default: 0,     null: false
    t.integer "status",             limit: 4,     default: 0,     null: false
    t.text    "read_members",       limit: 65535,                 null: false
    t.string  "membertypes",        limit: 255,                   null: false
    t.integer "membertype_id",      limit: 4,                     null: false
  end

  create_table "pb_announcementtypes", force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
  end

  create_table "pb_announcereads", force: :cascade do |t|
    t.integer  "member_id",   limit: 4, null: false
    t.integer  "announce_id", limit: 4, null: false
    t.integer  "times",       limit: 4, null: false
    t.datetime "created",               null: false
  end

  create_table "pb_areainfos", force: :cascade do |t|
    t.integer  "area_id",        limit: 4,                 null: false
    t.integer  "member_id",      limit: 4,                 null: false
    t.text     "content",        limit: 65535,             null: false
    t.integer  "status",         limit: 4,     default: 0, null: false
    t.datetime "created",                                  null: false
    t.integer  "area_moderator", limit: 4,                 null: false
  end

  create_table "pb_areas", force: :cascade do |t|
    t.integer "attachment_id", limit: 4,     default: 0,     null: false
    t.integer "areatype_id",   limit: 2,     default: 0,     null: false
    t.text    "child_ids",     limit: 65535
    t.integer "top_parentid",  limit: 2,     default: 0,     null: false
    t.boolean "level",                       default: true,  null: false
    t.string  "name",          limit: 255,   default: "",    null: false
    t.string  "url",           limit: 255,   default: "",    null: false
    t.string  "alias_name",    limit: 255,   default: "",    null: false
    t.boolean "highlight",                   default: false, null: false
    t.integer "parent_id",     limit: 2,     default: 0,     null: false
    t.integer "display_order", limit: 4,     default: 0,     null: false
    t.text    "description",   limit: 65535
    t.boolean "available",                   default: true,  null: false
    t.integer "created",       limit: 4,     default: 0,     null: false
    t.integer "modified",      limit: 4,     default: 0,     null: false
    t.string  "area_group",    limit: 255,                   null: false
    t.string  "map_lat",       limit: 255,                   null: false
    t.string  "map_lng",       limit: 255,                   null: false
    t.integer "map_zoom",      limit: 4,                     null: false
  end

  create_table "pb_areatypeinfos", force: :cascade do |t|
    t.integer  "areatype_id",    limit: 4,                 null: false
    t.integer  "member_id",      limit: 4,                 null: false
    t.text     "content",        limit: 65535,             null: false
    t.integer  "status",         limit: 4,     default: 0, null: false
    t.datetime "created",                                  null: false
    t.integer  "area_moderator", limit: 4,                 null: false
  end

  create_table "pb_areatypes", force: :cascade do |t|
    t.string  "name",     limit: 64,  default: "", null: false
    t.string  "map_lat",  limit: 255,              null: false
    t.string  "map_lng",  limit: 255,              null: false
    t.integer "map_zoom", limit: 4,                null: false
  end

  create_table "pb_attachmentcomments", force: :cascade do |t|
    t.integer  "member_id",     limit: 4,     null: false
    t.integer  "company_id",    limit: 4,     null: false
    t.integer  "attachment_id", limit: 4,     null: false
    t.text     "content",       limit: 65535, null: false
    t.datetime "created",                     null: false
    t.string   "guest_name",    limit: 255,   null: false
    t.string   "guest_email",   limit: 255,   null: false
  end

  create_table "pb_attachments", force: :cascade do |t|
    t.integer "attachmenttype_id", limit: 2,     default: 0,    null: false
    t.integer "member_id",         limit: 4,     default: -1,   null: false
    t.string  "file_name",         limit: 100,   default: "",   null: false
    t.string  "attachment",        limit: 255,   default: "",   null: false
    t.string  "title",             limit: 100,   default: "",   null: false
    t.text    "description",       limit: 65535
    t.string  "file_type",         limit: 50,    default: "0",  null: false
    t.integer "file_size",         limit: 3,     default: 0,    null: false
    t.string  "thumb",             limit: 100,   default: "",   null: false
    t.string  "remote",            limit: 100,   default: "",   null: false
    t.boolean "is_image",                        default: true, null: false
    t.boolean "status",                          default: true, null: false
    t.integer "created",           limit: 4,     default: 0,    null: false
    t.integer "modified",          limit: 4,     default: 0,    null: false
    t.integer "clicked",           limit: 4,     default: 0,    null: false
    t.text    "clicked_logs",      limit: 65535,                null: false
  end

  create_table "pb_attachmenttypes", force: :cascade do |t|
    t.string "name", limit: 25, default: "", null: false
  end

  create_table "pb_banned", force: :cascade do |t|
    t.string  "ip1",        limit: 3, default: "", null: false
    t.string  "ip2",        limit: 3, default: "", null: false
    t.string  "ip3",        limit: 3, default: "", null: false
    t.string  "ip4",        limit: 3, default: "", null: false
    t.integer "expiration", limit: 4, default: 0,  null: false
    t.integer "created",    limit: 4, default: 0,  null: false
  end

  add_index "pb_banned", ["ip1", "ip2", "ip3", "ip4"], name: "ip1", unique: true, using: :btree

  create_table "pb_brands", force: :cascade do |t|
    t.integer "member_id",   limit: 4,     default: -1,    null: false
    t.integer "company_id",  limit: 4,     default: -1,    null: false
    t.integer "type_id",     limit: 2,     default: 0,     null: false
    t.boolean "if_commend",                default: false, null: false
    t.string  "name",        limit: 100,   default: "",    null: false
    t.string  "alias_name",  limit: 100,   default: "",    null: false
    t.string  "picture",     limit: 255,   default: "",    null: false
    t.text    "description", limit: 65535,                 null: false
    t.integer "hits",        limit: 2,     default: 0,     null: false
    t.integer "ranks",       limit: 2,     default: 0,     null: false
    t.string  "letter",      limit: 2,     default: "",    null: false
    t.integer "created",     limit: 4,     default: 0,     null: false
    t.integer "modified",    limit: 4,     default: 0,     null: false
  end

  add_index "pb_brands", ["name"], name: "name", type: :fulltext

  create_table "pb_brandtypes", force: :cascade do |t|
    t.integer "parent_id",     limit: 2,   default: 0,     null: false
    t.boolean "level",                     default: true,  null: false
    t.string  "name",          limit: 100, default: "",    null: false
    t.boolean "display_order",             default: false, null: false
  end

  create_table "pb_cartitems", force: :cascade do |t|
    t.integer "cart_id",    limit: 4,             null: false
    t.integer "product_id", limit: 4,             null: false
    t.integer "quantity",   limit: 4, default: 1
  end

  add_index "pb_cartitems", ["cart_id", "product_id"], name: "cart_id_2", using: :btree
  add_index "pb_cartitems", ["cart_id"], name: "cart_id", using: :btree
  add_index "pb_cartitems", ["cart_id"], name: "cart_id_3", using: :btree
  add_index "pb_cartitems", ["cart_id"], name: "cart_id_4", using: :btree
  add_index "pb_cartitems", ["product_id"], name: "product_id", using: :btree
  add_index "pb_cartitems", ["product_id"], name: "product_id_2", using: :btree
  add_index "pb_cartitems", ["product_id"], name: "product_id_3", using: :btree

  create_table "pb_carts", force: :cascade do |t|
    t.integer "member_id", limit: 4, null: false
    t.integer "created",   limit: 4, null: false
  end

  add_index "pb_carts", ["member_id", "created"], name: "member_id_2", using: :btree
  add_index "pb_carts", ["member_id"], name: "member_id", using: :btree

  create_table "pb_chats", force: :cascade do |t|
    t.string  "type",                limit: 7,     default: "user", null: false
    t.integer "from_member_id",      limit: 4,     default: -1,     null: false
    t.string  "cache_from_username", limit: 25,    default: "",     null: false
    t.integer "to_member_id",        limit: 4,     default: -1,     null: false
    t.string  "cache_to_username",   limit: 25,    default: "",     null: false
    t.string  "title",               limit: 255,   default: "",     null: false
    t.text    "content",             limit: 65535
    t.boolean "status",                            default: false,  null: false
    t.integer "created",             limit: 4,     default: 0,      null: false
    t.integer "announce",            limit: 4,     default: 0,      null: false
    t.integer "read",                limit: 4,     default: 0,      null: false
    t.integer "viewed_date",         limit: 4,                      null: false
    t.string  "membertype_to_ids",   limit: 255,                    null: false
    t.string  "membertype_from_ids", limit: 255,                    null: false
    t.string  "chatid",              limit: 255,                    null: false
    t.string  "to_code",             limit: 255,                    null: false
    t.string  "from_code",           limit: 255,                    null: false
    t.string  "chat_code",           limit: 255,                    null: false
  end

  add_index "pb_chats", ["announce"], name: "announce", using: :btree
  add_index "pb_chats", ["chat_code"], name: "chat_code", using: :btree
  add_index "pb_chats", ["chat_code"], name: "chat_code_2", using: :btree
  add_index "pb_chats", ["chatid"], name: "chatid", using: :btree
  add_index "pb_chats", ["chatid"], name: "chatid_2", using: :btree
  add_index "pb_chats", ["created"], name: "created", using: :btree
  add_index "pb_chats", ["created"], name: "created_2", using: :btree
  add_index "pb_chats", ["from_code"], name: "from_code", using: :btree
  add_index "pb_chats", ["from_code"], name: "from_code_2", using: :btree
  add_index "pb_chats", ["from_code"], name: "from_code_3", using: :btree
  add_index "pb_chats", ["from_code"], name: "from_code_4", using: :btree
  add_index "pb_chats", ["from_member_id"], name: "from_member_id", using: :btree
  add_index "pb_chats", ["membertype_from_ids"], name: "membertype_from_ids", using: :btree
  add_index "pb_chats", ["membertype_from_ids"], name: "membertype_from_ids_2", using: :btree
  add_index "pb_chats", ["membertype_to_ids"], name: "membertype_to_ids", using: :btree
  add_index "pb_chats", ["membertype_to_ids"], name: "membertype_to_ids_2", using: :btree
  add_index "pb_chats", ["read"], name: "read", using: :btree
  add_index "pb_chats", ["status"], name: "status", using: :btree
  add_index "pb_chats", ["to_code"], name: "to_code", using: :btree
  add_index "pb_chats", ["to_code"], name: "to_code_2", using: :btree
  add_index "pb_chats", ["to_code"], name: "to_code_3", using: :btree
  add_index "pb_chats", ["to_code"], name: "to_code_4", using: :btree
  add_index "pb_chats", ["to_member_id"], name: "to_member_id", using: :btree
  add_index "pb_chats", ["type"], name: "type", using: :btree
  add_index "pb_chats", ["viewed_date"], name: "viewed_date", using: :btree

  create_table "pb_checkouttransactions", force: :cascade do |t|
    t.integer  "member_id", limit: 4,     null: false
    t.integer  "parent_id", limit: 4,     null: false
    t.integer  "grand_id",  limit: 4,     null: false
    t.datetime "created",                 null: false
    t.integer  "months",    limit: 4,     null: false
    t.text     "amount",    limit: 65535, null: false
    t.text     "note",      limit: 65535, null: false
  end

  create_table "pb_companies", force: :cascade do |t|
    t.integer "member_id",           limit: 4,     default: 0,     null: false
    t.string  "cache_spacename",     limit: 255,   default: "",    null: false
    t.integer "cache_membergroupid", limit: 2,     default: 0,     null: false
    t.integer "cache_credits",       limit: 2,     default: 0,     null: false
    t.string  "topleveldomain",      limit: 255,   default: "",    null: false
    t.integer "industry_id",         limit: 2,     default: 0,     null: false
    t.string  "area_id",             limit: 6,     default: "0",   null: false
    t.integer "type_id",             limit: 1,     default: 0,     null: false
    t.string  "name",                limit: 255,   default: "",    null: false
    t.text    "description",         limit: 65535
    t.string  "english_name",        limit: 100,   default: "",    null: false
    t.string  "adwords",             limit: 25,    default: "",    null: false
    t.string  "keywords",            limit: 50,    default: "",    null: false
    t.string  "boss_name",           limit: 25,    default: "",    null: false
    t.string  "manage_type",         limit: 25,    default: "",    null: false
    t.string  "year_annual",         limit: 255
    t.string  "property",            limit: 255
    t.text    "configs",             limit: 65535
    t.string  "bank_from",           limit: 50,    default: "",    null: false
    t.string  "bank_account",        limit: 50,    default: "",    null: false
    t.string  "main_prod",           limit: 100,   default: "",    null: false
    t.string  "employee_amount",     limit: 25,    default: "",    null: false
    t.string  "found_date",          limit: 10,    default: "0",   null: false
    t.string  "reg_fund",            limit: 255
    t.string  "reg_address",         limit: 200,   default: "",    null: false
    t.string  "address",             limit: 200,   default: "",    null: false
    t.string  "zipcode",             limit: 15,    default: "",    null: false
    t.string  "main_brand",          limit: 100,   default: "",    null: false
    t.string  "main_market",         limit: 200,   default: "",    null: false
    t.string  "main_biz_place",      limit: 50,    default: "",    null: false
    t.string  "main_customer",       limit: 200,   default: "",    null: false
    t.string  "link_man",            limit: 25,    default: "",    null: false
    t.boolean "link_man_gender",                   default: false, null: false
    t.string  "position",            limit: 255
    t.string  "tel",                 limit: 25,    default: "",    null: false
    t.string  "fax",                 limit: 25,    default: "",    null: false
    t.string  "mobile",              limit: 25,    default: "",    null: false
    t.string  "email",               limit: 100,   default: "",    null: false
    t.string  "site_url",            limit: 100,   default: "",    null: false
    t.string  "picture",             limit: 50,    default: "",    null: false
    t.boolean "status",                            default: false, null: false
    t.string  "first_letter",        limit: 2,     default: "",    null: false
    t.boolean "if_commend",                        default: false, null: false
    t.integer "clicked",             limit: 4,     default: 1,     null: false
    t.integer "created",             limit: 4,     default: 0,     null: false
    t.integer "modified",            limit: 4,     default: 0,     null: false
    t.text    "banner",              limit: 65535
    t.string  "chairman",            limit: 255
    t.string  "mst",                 limit: 255
    t.string  "contact_mobile",      limit: 255
    t.string  "contact_email",       limit: 255
    t.string  "vp_address",          limit: 255
    t.string  "vp_fax",              limit: 255
    t.string  "vp_email",            limit: 255
    t.string  "shop_name",           limit: 255
    t.text    "policy",              limit: 65535
    t.string  "registration_date",   limit: 255
    t.string  "facebook",            limit: 255
    t.integer "new_clicked",         limit: 4,     default: 0,     null: false
    t.string  "new_clicked_date",    limit: 255
    t.text    "custom_style",        limit: 65535,                 null: false
    t.text    "banners",             limit: 65535
    t.string  "industries",          limit: 500
    t.text    "tag_ids",             limit: 65535,                 null: false
    t.text    "keywords_string",     limit: 65535,                 null: false
    t.text    "facebook_personal",   limit: 65535,                 null: false
    t.integer "fb_post_wall",        limit: 4,     default: 0,     null: false
    t.text    "fb_post_fanpage",     limit: 65535,                 null: false
    t.text    "fb_fanpage_main",     limit: 65535,                 null: false
    t.integer "vote_count",          limit: 4,                     null: false
    t.integer "vote_sum",            limit: 4,                     null: false
    t.float   "vote_result",         limit: 24,                    null: false
    t.integer "area_show",           limit: 4,     default: 1,     null: false
    t.integer "new_product_show",    limit: 4,     default: 1,     null: false
    t.string  "map_lat",             limit: 255,                   null: false
    t.string  "map_lng",             limit: 255,                   null: false
    t.integer "companypage_show",    limit: 4,     default: 1,     null: false
    t.integer "new_home",            limit: 4,     default: 0,     null: false
  end

  add_index "pb_companies", ["area_show"], name: "area_show", using: :btree
  add_index "pb_companies", ["cache_spacename"], name: "cache_spacename", using: :btree
  add_index "pb_companies", ["cache_spacename"], name: "cache_spacename_2", using: :btree
  add_index "pb_companies", ["cache_spacename"], name: "cache_spacename_3", using: :btree
  add_index "pb_companies", ["cache_spacename"], name: "cache_spacename_4", using: :btree
  add_index "pb_companies", ["cache_spacename"], name: "cache_spacename_5", using: :btree
  add_index "pb_companies", ["cache_spacename"], name: "cache_spacename_6", using: :btree
  add_index "pb_companies", ["description"], name: "description", type: :fulltext
  add_index "pb_companies", ["industries"], name: "industries", length: {"industries"=>333}, using: :btree
  add_index "pb_companies", ["industry_id", "area_id"], name: "industry_id1", using: :btree
  add_index "pb_companies", ["industry_id", "area_id"], name: "industry_id1_2", using: :btree
  add_index "pb_companies", ["keywords_string"], name: "keywords_string", type: :fulltext
  add_index "pb_companies", ["keywords_string"], name: "keywords_string_2", type: :fulltext
  add_index "pb_companies", ["member_id"], name: "member_id", using: :btree
  add_index "pb_companies", ["member_id"], name: "member_id_2", using: :btree
  add_index "pb_companies", ["member_id"], name: "member_id_3", using: :btree
  add_index "pb_companies", ["name", "description", "shop_name"], name: "name_5", type: :fulltext
  add_index "pb_companies", ["name", "description", "shop_name"], name: "name_6", type: :fulltext
  add_index "pb_companies", ["name", "description", "shop_name"], name: "name_7", type: :fulltext
  add_index "pb_companies", ["name"], name: "name", using: :btree
  add_index "pb_companies", ["name"], name: "name_2", using: :btree
  add_index "pb_companies", ["name"], name: "name_3", using: :btree
  add_index "pb_companies", ["name"], name: "name_4", type: :fulltext
  add_index "pb_companies", ["name"], name: "name_8", type: :fulltext
  add_index "pb_companies", ["name"], name: "name_9", using: :btree
  add_index "pb_companies", ["picture", "status"], name: "picture_2", using: :btree
  add_index "pb_companies", ["picture"], name: "picture", using: :btree
  add_index "pb_companies", ["picture"], name: "picture_3", using: :btree
  add_index "pb_companies", ["shop_name", "name", "keywords_string", "description"], name: "shop_name_2", type: :fulltext
  add_index "pb_companies", ["shop_name", "name"], name: "shop_name_3", type: :fulltext
  add_index "pb_companies", ["shop_name"], name: "shop_name", type: :fulltext
  add_index "pb_companies", ["shop_name"], name: "shop_name_4", type: :fulltext
  add_index "pb_companies", ["shop_name"], name: "shop_name_5", using: :btree
  add_index "pb_companies", ["status"], name: "status", using: :btree
  add_index "pb_companies", ["status"], name: "status_2", using: :btree
  add_index "pb_companies", ["status"], name: "status_3", using: :btree
  add_index "pb_companies", ["topleveldomain"], name: "topleveldomain", using: :btree

  create_table "pb_companyfields", primary_key: "company_id", force: :cascade do |t|
    t.string "map_longitude", limit: 25, default: "", null: false
    t.string "map_latitude",  limit: 25, default: "", null: false
  end

  create_table "pb_companynewses", force: :cascade do |t|
    t.integer "member_id",  limit: 4,     default: -1,    null: false
    t.integer "company_id", limit: 4,     default: -1,    null: false
    t.integer "type_id",    limit: 2,     default: 0,     null: false
    t.string  "title",      limit: 100,   default: "",    null: false
    t.text    "content",    limit: 65535
    t.string  "picture",    limit: 100,   default: "",    null: false
    t.boolean "status",                   default: false, null: false
    t.integer "clicked",    limit: 4,     default: 1,     null: false
    t.integer "created",    limit: 4,     default: 0,     null: false
    t.integer "modified",   limit: 4,     default: 0,     null: false
  end

  create_table "pb_companynewstypes", force: :cascade do |t|
    t.string  "name",          limit: 255, default: "",    null: false
    t.boolean "display_order",             default: false, null: false
  end

  create_table "pb_companyoffices", force: :cascade do |t|
    t.integer  "company_id",       limit: 4,     null: false
    t.text     "name",             limit: 65535, null: false
    t.integer  "area_id",          limit: 4,     null: false
    t.text     "address",          limit: 65535, null: false
    t.string   "phone",            limit: 255,   null: false
    t.string   "fax",              limit: 255,   null: false
    t.string   "email",            limit: 255,   null: false
    t.string   "website",          limit: 255,   null: false
    t.string   "contact_name",     limit: 255,   null: false
    t.string   "contact_mobile",   limit: 255,   null: false
    t.string   "contact_position", limit: 255,   null: false
    t.string   "contact_email",    limit: 255,   null: false
    t.text     "facebook",         limit: 65535, null: false
    t.text     "facebook_fanpage", limit: 65535, null: false
    t.datetime "created",                        null: false
  end

  create_table "pb_companytypes", force: :cascade do |t|
    t.string  "name",          limit: 100, default: "",    null: false
    t.boolean "display_order",             default: false, null: false
    t.string  "url",           limit: 100, default: "",    null: false
  end

  create_table "pb_connectpaidnotes", force: :cascade do |t|
    t.integer  "member_id", limit: 4,   null: false
    t.integer  "point",     limit: 4,   null: false
    t.string   "type",      limit: 255, null: false
    t.datetime "created",               null: false
  end

  create_table "pb_countries", force: :cascade do |t|
    t.string  "name",          limit: 100, default: "",  null: false
    t.string  "picture",       limit: 100, default: "0", null: false
    t.integer "display_order", limit: 2,   default: 0,   null: false
  end

  create_table "pb_dicts", force: :cascade do |t|
    t.integer "dicttype_id",       limit: 2,     default: 0,     null: false
    t.string  "extend_dicttypeid", limit: 25,    default: "",    null: false
    t.string  "word",              limit: 255,   default: "",    null: false
    t.string  "word_name",         limit: 255,   default: "",    null: false
    t.string  "digest",            limit: 255,   default: "",    null: false
    t.text    "content",           limit: 65535
    t.string  "picture",           limit: 255,   default: "",    null: false
    t.text    "refer",             limit: 255
    t.integer "hits",              limit: 4,     default: 1,     null: false
    t.boolean "closed",                          default: false, null: false
    t.boolean "if_commend",                      default: false, null: false
    t.integer "created",           limit: 4,     default: 0,     null: false
    t.integer "modified",          limit: 4,     default: 0,     null: false
  end

  create_table "pb_dicttypes", force: :cascade do |t|
    t.string  "name",          limit: 255, default: "",    null: false
    t.integer "parent_id",     limit: 2,   default: 0,     null: false
    t.boolean "display_order",             default: false, null: false
  end

  create_table "pb_employeeeducations", force: :cascade do |t|
    t.integer "employee_id", limit: 4,     null: false
    t.integer "member_id",   limit: 4,     null: false
    t.string  "level_id",    limit: 255,   null: false
    t.text    "major",       limit: 65535, null: false
    t.integer "startmonth",  limit: 4,     null: false
    t.integer "startyear",   limit: 4,     null: false
    t.integer "endmonth",    limit: 4,     null: false
    t.integer "endyear",     limit: 4,     null: false
    t.text    "content",     limit: 65535, null: false
    t.string  "current",     limit: 50,    null: false
    t.string  "school_name", limit: 255,   null: false
    t.integer "order_num",   limit: 4,     null: false
  end

  create_table "pb_employeeexperiences", force: :cascade do |t|
    t.integer "employee_id",        limit: 4,     null: false
    t.integer "member_id",          limit: 4,     null: false
    t.string  "job_title",          limit: 255,   null: false
    t.string  "company_name",       limit: 255,   null: false
    t.integer "job_proficiency_id", limit: 4,     null: false
    t.integer "jobindust_id",       limit: 4,     null: false
    t.integer "startmonth",         limit: 4,     null: false
    t.integer "startyear",          limit: 4,     null: false
    t.integer "endmonth",           limit: 4,     null: false
    t.integer "endyear",            limit: 4,     null: false
    t.text    "content",            limit: 65535, null: false
    t.string  "current",            limit: 50,    null: false
    t.integer "order_num",          limit: 4,     null: false
  end

  create_table "pb_employeereferences", force: :cascade do |t|
    t.integer "employee_id", limit: 4,     null: false
    t.integer "member_id",   limit: 4,     null: false
    t.string  "name",        limit: 255,   null: false
    t.text    "title",       limit: 65535, null: false
    t.text    "company",     limit: 65535, null: false
    t.string  "email",       limit: 255,   null: false
    t.string  "phone",       limit: 50,    null: false
    t.integer "order_num",   limit: 4,     null: false
  end

  create_table "pb_employees", force: :cascade do |t|
    t.integer "member_id",         limit: 4,                 null: false
    t.integer "company_id",        limit: 4,                 null: false
    t.integer "newgrad",           limit: 4,                 null: false
    t.string  "years_experience",  limit: 255,               null: false
    t.text    "languages",         limit: 65535,             null: false
    t.string  "expected_position", limit: 255,               null: false
    t.integer "joblevel_id",       limit: 4,                 null: false
    t.text    "areas",             limit: 65535,             null: false
    t.text    "jobindusts",        limit: 65535,             null: false
    t.string  "salary",            limit: 255,               null: false
    t.string  "salary_currency",   limit: 255,               null: false
    t.text    "career_objective",  limit: 65535,             null: false
    t.text    "career_highlight",  limit: 65535,             null: false
    t.text    "employeeexpers",    limit: 65535,             null: false
    t.text    "employeeeducs",     limit: 65535,             null: false
    t.text    "skills",            limit: 65535,             null: false
    t.text    "employeerefers",    limit: 65535,             null: false
    t.integer "created",           limit: 4,                 null: false
    t.integer "modified",          limit: 4,                 null: false
    t.integer "status",            limit: 4,     default: 0, null: false
    t.integer "clicked",           limit: 4,     default: 0, null: false
    t.integer "showed",            limit: 4,     default: 1, null: false
    t.integer "searched",          limit: 4,     default: 0, null: false
  end

  create_table "pb_expomembers", force: :cascade do |t|
    t.integer "expo_id",    limit: 2, default: 0,  null: false
    t.integer "member_id",  limit: 4, default: -1, null: false
    t.integer "company_id", limit: 4, default: -1, null: false
    t.integer "created",    limit: 4, default: 0,  null: false
    t.integer "modified",   limit: 4, default: 0,  null: false
  end

  add_index "pb_expomembers", ["expo_id", "member_id"], name: "expo_id", unique: true, using: :btree

  create_table "pb_expos", force: :cascade do |t|
    t.integer "expotype_id",      limit: 2,     default: 0,     null: false
    t.string  "name",             limit: 100,   default: "",    null: false
    t.text    "description",      limit: 65535
    t.integer "begin_time",       limit: 4,     default: 0,     null: false
    t.integer "end_time",         limit: 4,     default: 0,     null: false
    t.string  "industry_ids",     limit: 100,   default: "0",   null: false
    t.integer "industry_id",      limit: 2,     default: 0,     null: false
    t.integer "area_id",          limit: 2,     default: 0,     null: false
    t.string  "address",          limit: 100,   default: "",    null: false
    t.string  "stadium_name",     limit: 100,   default: "",    null: false
    t.string  "refresh_method",   limit: 100,   default: "",    null: false
    t.string  "scope",            limit: 100,   default: "",    null: false
    t.string  "hosts",            limit: 255,   default: "",    null: false
    t.string  "organisers",       limit: 255,   default: "",    null: false
    t.string  "co_organisers",    limit: 255,   default: "",    null: false
    t.string  "sponsors",         limit: 255,   default: "",    null: false
    t.text    "contacts",         limit: 65535
    t.text    "important_notice", limit: 65535
    t.string  "picture",          limit: 100,   default: "",    null: false
    t.boolean "if_commend",                     default: false, null: false
    t.boolean "status",                         default: false, null: false
    t.integer "hits",             limit: 2,     default: 1,     null: false
    t.integer "created",          limit: 4,     default: 0,     null: false
    t.integer "modified",         limit: 4,     default: 0,     null: false
  end

  add_index "pb_expos", ["status"], name: "status", using: :btree
  add_index "pb_expos", ["status"], name: "status_2", using: :btree
  add_index "pb_expos", ["status"], name: "status_3", using: :btree

  create_table "pb_expostadiums", force: :cascade do |t|
    t.string  "sa",          limit: 100,   default: ""
    t.integer "country_id",  limit: 2,     default: 0
    t.integer "province_id", limit: 2,     default: 0
    t.integer "city_id",     limit: 2,     default: 0
    t.string  "sb",          limit: 200,   default: ""
    t.string  "sc",          limit: 150,   default: ""
    t.string  "sd",          limit: 150,   default: ""
    t.string  "se",          limit: 150,   default: ""
    t.string  "sf",          limit: 150,   default: ""
    t.text    "sg",          limit: 65535
    t.integer "sh",          limit: 2,     default: 0
    t.integer "created",     limit: 4
    t.integer "modified",    limit: 4
  end

  create_table "pb_expotypes", force: :cascade do |t|
    t.string  "name",     limit: 50, default: "", null: false
    t.integer "created",  limit: 4,  default: 0,  null: false
    t.integer "modified", limit: 4,  default: 0,  null: false
  end

  create_table "pb_favorites", force: :cascade do |t|
    t.integer "member_id", limit: 4, default: -1,    null: false
    t.integer "target_id", limit: 4, default: -1,    null: false
    t.boolean "type_id",             default: false, null: false
    t.integer "created",   limit: 4, default: 0,     null: false
    t.integer "modified",  limit: 4, default: 0,     null: false
  end

  add_index "pb_favorites", ["member_id", "target_id", "type_id"], name: "member_id", unique: true, using: :btree

  create_table "pb_fbsharelogs", force: :cascade do |t|
    t.text     "link",          limit: 65535, null: false
    t.text     "fb_page",       limit: 65535, null: false
    t.string   "type",          limit: 255,   null: false
    t.text     "title",         limit: 65535, null: false
    t.datetime "created",                     null: false
    t.text     "error_message", limit: 65535, null: false
    t.text     "message",       limit: 65535, null: false
    t.string   "kind",          limit: 255,   null: false
  end

  create_table "pb_feeds", force: :cascade do |t|
    t.boolean "type_id",                 default: false, null: false
    t.string  "type",      limit: 100,   default: "",    null: false
    t.integer "member_id", limit: 4,     default: 0,     null: false
    t.string  "username",  limit: 100,   default: "",    null: false
    t.text    "data",      limit: 65535,                 null: false
    t.integer "created",   limit: 4,     default: 0,     null: false
    t.integer "modified",  limit: 4,     default: 0,     null: false
  end

  create_table "pb_follows", force: :cascade do |t|
    t.integer "member_id", limit: 4, null: false
    t.integer "shop_id",   limit: 4, null: false
    t.date    "created",             null: false
  end

  create_table "pb_formattributes", force: :cascade do |t|
    t.boolean "type_id",                   default: false, null: false
    t.integer "form_id",     limit: 2,     default: 0,     null: false
    t.integer "formitem_id", limit: 2,     default: 0,     null: false
    t.integer "primary_id",  limit: 4,     default: -1,    null: false
    t.text    "attribute",   limit: 65535
  end

  add_index "pb_formattributes", ["form_id"], name: "form_id", using: :btree
  add_index "pb_formattributes", ["formitem_id"], name: "formitem_id", using: :btree
  add_index "pb_formattributes", ["primary_id"], name: "primary_id", using: :btree
  add_index "pb_formattributes", ["type_id"], name: "type_id", using: :btree

  create_table "pb_formitems", force: :cascade do |t|
    t.integer "form_id",       limit: 2,     default: 0,      null: false
    t.string  "title",         limit: 100,   default: "",     null: false
    t.text    "description",   limit: 65535
    t.string  "identifier",    limit: 50,    default: "",     null: false
    t.string  "type",          limit: 8,     default: "text", null: false
    t.text    "rules",         limit: 65535
    t.boolean "display_order",               default: false,  null: false
  end

  create_table "pb_forms", force: :cascade do |t|
    t.boolean "type_id",               default: false, null: false
    t.string  "name",    limit: 100,   default: "",    null: false
    t.text    "items",   limit: 65535
  end

  create_table "pb_friendlinks", force: :cascade do |t|
    t.boolean "friendlinktype_id",               default: false, null: false
    t.integer "industry_id",       limit: 2,     default: 0,     null: false
    t.integer "area_id",           limit: 2,     default: 0,     null: false
    t.string  "title",             limit: 50,    default: "",    null: false
    t.string  "logo",              limit: 100,   default: "",    null: false
    t.string  "url",               limit: 50,    default: "",    null: false
    t.integer "priority",          limit: 2,     default: 0,     null: false
    t.boolean "status",                          default: true,  null: false
    t.text    "description",       limit: 65535
    t.integer "created",           limit: 4,     default: 0,     null: false
    t.integer "modified",          limit: 4,     default: 0,     null: false
  end

  create_table "pb_friendlinktypes", force: :cascade do |t|
    t.string "name", limit: 25, default: "", null: false
  end

  create_table "pb_goods", force: :cascade do |t|
    t.integer "type_id",     limit: 2,     default: 0,     null: false
    t.string  "name",        limit: 255,   default: "",    null: false
    t.text    "description", limit: 65535
    t.float   "price",       limit: 24,    default: 0.0,   null: false
    t.boolean "closed",                    default: true,  null: false
    t.string  "picture",     limit: 100,   default: "",    null: false
    t.boolean "if_commend",                default: false, null: false
    t.integer "created",     limit: 4,     default: 0,     null: false
    t.integer "modified",    limit: 4,     default: 0,     null: false
  end

  create_table "pb_goodtypes", force: :cascade do |t|
    t.string  "name",          limit: 100, default: "",    null: false
    t.boolean "display_order",             default: false, null: false
  end

  create_table "pb_googlecontacts", force: :cascade do |t|
    t.integer  "member_id", limit: 4,     null: false
    t.text     "data",      limit: 65535, null: false
    t.datetime "created",                 null: false
  end

  add_index "pb_googlecontacts", ["id"], name: "id", using: :btree

  create_table "pb_helps", force: :cascade do |t|
    t.integer "helptype_id", limit: 2,     default: 0,     null: false
    t.string  "title",       limit: 100,   default: "",    null: false
    t.text    "content",     limit: 65535
    t.boolean "highlight",                 default: false, null: false
    t.integer "created",     limit: 4,     default: 0,     null: false
    t.integer "modified",    limit: 4,     default: 0,     null: false
  end

  create_table "pb_helptypes", force: :cascade do |t|
    t.string  "title",         limit: 100, default: "",    null: false
    t.string  "description",   limit: 100, default: "",    null: false
    t.integer "parent_id",     limit: 2,   default: 0,     null: false
    t.boolean "level",                     default: false, null: false
    t.boolean "display_order",             default: false, null: false
    t.integer "created",       limit: 4,   default: 0,     null: false
    t.integer "modified",      limit: 4,   default: 0,     null: false
  end

  create_table "pb_industries", force: :cascade do |t|
    t.integer "attachment_id",   limit: 4,     default: 0,     null: false
    t.integer "industrytype_id", limit: 2,     default: 0,     null: false
    t.text    "child_ids",       limit: 65535
    t.string  "name",            limit: 255,   default: "",    null: false
    t.string  "url",             limit: 255,   default: "",    null: false
    t.string  "alias_name",      limit: 255,   default: "",    null: false
    t.boolean "highlight",                     default: false, null: false
    t.integer "parent_id",       limit: 2,     default: 0,     null: false
    t.integer "top_parentid",    limit: 2,     default: 0,     null: false
    t.boolean "level",                         default: true,  null: false
    t.boolean "display_order",                 default: false, null: false
    t.text    "description",     limit: 65535
    t.boolean "available",                     default: true,  null: false
    t.integer "created",         limit: 4,     default: 0,     null: false
    t.integer "modified",        limit: 4,     default: 0,     null: false
    t.string  "tempurl",         limit: 255
    t.string  "picture",         limit: 255
    t.integer "count",           limit: 4,                     null: false
    t.text    "children",        limit: 65535
    t.string  "industries",      limit: 500
    t.integer "share_facebook",  limit: 4,     default: 0,     null: false
    t.text    "ad_price",        limit: 65535,                 null: false
  end

  add_index "pb_industries", ["parent_id"], name: "parent_id", using: :btree
  add_index "pb_industries", ["top_parentid"], name: "top_parentid", using: :btree

  create_table "pb_industrytypes", force: :cascade do |t|
    t.string "name", limit: 64, default: "", null: false
  end

  create_table "pb_inqueries", force: :cascade do |t|
    t.integer "to_member_id",  limit: 4
    t.integer "to_company_id", limit: 4
    t.string  "title",         limit: 50,    default: "",  null: false
    t.text    "content",       limit: 65535
    t.boolean "send_achive"
    t.string  "know_more",     limit: 50,    default: "",  null: false
    t.string  "exp_quantity",  limit: 15,    default: "",  null: false
    t.float   "exp_price",     limit: 24,    default: 0.0, null: false
    t.text    "contacts",      limit: 65535
    t.string  "user_ip",       limit: 11,    default: ""
    t.integer "created",       limit: 4,     default: 0,   null: false
  end

  create_table "pb_jobcats", force: :cascade do |t|
    t.integer "parent_id",     limit: 2,     default: 0,     null: false
    t.boolean "level",                       default: true,  null: false
    t.string  "name",          limit: 255,   default: "",    null: false
    t.boolean "display_order",               default: false, null: false
    t.string  "group",         limit: 255,                   null: false
    t.text    "link",          limit: 65535,                 null: false
  end

  create_table "pb_jobindusts", force: :cascade do |t|
    t.integer "parent_id",     limit: 2,     default: 0,     null: false
    t.boolean "level",                       default: true,  null: false
    t.string  "name",          limit: 255,   default: "",    null: false
    t.boolean "display_order",               default: false, null: false
    t.string  "group",         limit: 255,                   null: false
    t.text    "link",          limit: 65535,                 null: false
  end

  create_table "pb_jobs", force: :cascade do |t|
    t.integer "member_id",            limit: 4,     default: -1,    null: false
    t.integer "company_id",           limit: 4,     default: -1,    null: false
    t.string  "cache_spacename",      limit: 25,    default: "",    null: false
    t.integer "industry_id",          limit: 2,     default: 0,     null: false
    t.integer "area_id",              limit: 2,     default: 0,     null: false
    t.string  "name",                 limit: 150,   default: "",    null: false
    t.string  "work_station",         limit: 50,    default: "",    null: false
    t.text    "content",              limit: 65535
    t.boolean "require_gender_id",                  default: false, null: false
    t.string  "peoples",              limit: 5,     default: "",    null: false
    t.boolean "require_education_id",               default: false, null: false
    t.string  "require_age",          limit: 10,    default: "",    null: false
    t.boolean "salary_id",                          default: false, null: false
    t.boolean "worktype_id",                        default: false, null: false
    t.boolean "status",                             default: false, null: false
    t.integer "clicked",              limit: 4,     default: 1,     null: false
    t.integer "jobtype_id",           limit: 2,     default: 0,     null: false
    t.integer "expire_time",          limit: 4,     default: 0,     null: false
    t.integer "created",              limit: 4,     default: 0,     null: false
    t.integer "modified",             limit: 4,     default: 0,     null: false
    t.text    "exper",                limit: 65535
    t.text    "testtime",             limit: 65535
    t.text    "skills",               limit: 65535
    t.text    "rprofile",             limit: 65535
    t.text    "job_other",            limit: 65535
    t.string  "jobtype",              limit: 255
    t.string  "expired_dates",        limit: 255
    t.string  "industry",             limit: 255
    t.string  "salary",               limit: 255
    t.text    "jobcats",              limit: 65535,                 null: false
    t.text    "jobindusts",           limit: 65535,                 null: false
    t.text    "link",                 limit: 65535,                 null: false
    t.string  "salary_currency",      limit: 255,                   null: false
    t.string  "contact_name",         limit: 255,                   null: false
    t.integer "contact_gender",       limit: 4,                     null: false
    t.string  "contact_position",     limit: 255,                   null: false
    t.string  "contact_mobile",       limit: 255,                   null: false
    t.string  "contact_email",        limit: 255,                   null: false
    t.string  "work_address",         limit: 500,                   null: false
    t.integer "area_show",            limit: 4,     default: 1,     null: false
  end

  create_table "pb_jobtypes", force: :cascade do |t|
    t.integer "parent_id",     limit: 2,     default: 0,     null: false
    t.boolean "level",                       default: true,  null: false
    t.string  "name",          limit: 255,   default: "",    null: false
    t.boolean "display_order",               default: false, null: false
    t.string  "group",         limit: 255,                   null: false
    t.text    "link",          limit: 65535,                 null: false
  end

  create_table "pb_keywords", force: :cascade do |t|
    t.string  "title",           limit: 25, default: "",       null: false
    t.integer "target_id",       limit: 4,  default: 0,        null: false
    t.boolean "target_position",            default: false,    null: false
    t.string  "type_name",       limit: 9,  default: "trades", null: false
    t.integer "hits",            limit: 2,  default: 1,        null: false
    t.boolean "status",                     default: false,    null: false
  end

  add_index "pb_keywords", ["title"], name: "title", using: :btree

  create_table "pb_languages", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "pb_links", id: false, force: :cascade do |t|
    t.integer  "id",        limit: 4, null: false
    t.integer  "parent_id", limit: 4, null: false
    t.integer  "member_id", limit: 4, null: false
    t.integer  "type_id",   limit: 4, null: false
    t.datetime "created",             null: false
  end

  create_table "pb_logs", id: false, force: :cascade do |t|
    t.integer "id",            limit: 4,                      null: false
    t.string  "handle_type",   limit: 7,     default: "info", null: false
    t.string  "source_module", limit: 50,    default: "",     null: false
    t.text    "description",   limit: 65535
    t.integer "ip_address",    limit: 4,     default: 0,      null: false
    t.integer "created",       limit: 4,     default: 0,      null: false
    t.integer "modified",      limit: 4,     default: 0,      null: false
  end

  create_table "pb_markets", id: false, force: :cascade do |t|
    t.integer "id",            limit: 4,                     null: false
    t.string  "name",          limit: 255,   default: "",    null: false
    t.string  "main_business", limit: 255,   default: "",    null: false
    t.text    "content",       limit: 65535
    t.integer "markettype_id", limit: 2,     default: 0,     null: false
    t.integer "area_id",       limit: 2,     default: 0,     null: false
    t.integer "industry_id",   limit: 2,     default: 0,     null: false
    t.string  "picture",       limit: 50,    default: "",    null: false
    t.integer "ip_address",    limit: 4,     default: 0,     null: false
    t.boolean "status",                      default: false, null: false
    t.integer "clicked",       limit: 2,     default: 1,     null: false
    t.boolean "if_commend",                  default: false, null: false
    t.integer "created",       limit: 4,     default: 0,     null: false
    t.integer "modified",      limit: 4,     default: 0,     null: false
  end

  create_table "pb_markettypes", id: false, force: :cascade do |t|
    t.integer "id",            limit: 2,                   null: false
    t.string  "name",          limit: 255, default: "",    null: false
    t.boolean "display_order",             default: false, null: false
  end

  create_table "pb_membercaches", id: false, force: :cascade do |t|
    t.integer "member_id",  limit: 4,     default: -1, null: false
    t.text    "data1",      limit: 65535,              null: false
    t.text    "data2",      limit: 65535,              null: false
    t.integer "expiration", limit: 4,     default: 0,  null: false
  end

  create_table "pb_memberfields", force: :cascade do |t|
    t.integer "member_id",    limit: 4,     default: 0,     null: false
    t.integer "today_logins", limit: 2,     default: 0,     null: false
    t.integer "total_logins", limit: 2,     default: 0,     null: false
    t.integer "area_id",      limit: 2,     default: 0,     null: false
    t.string  "first_name",   limit: 25,    default: "",    null: false
    t.string  "last_name",    limit: 25,    default: "",    null: false
    t.boolean "gender",                     default: false, null: false
    t.string  "tel",          limit: 25,    default: "",    null: false
    t.string  "fax",          limit: 25,    default: "",    null: false
    t.string  "mobile",       limit: 25,    default: "",    null: false
    t.string  "qq",           limit: 12,    default: "",    null: false
    t.string  "msn",          limit: 50,    default: "",    null: false
    t.string  "icq",          limit: 12,    default: "",    null: false
    t.string  "yahoo",        limit: 50,    default: "",    null: false
    t.string  "skype",        limit: 50,    default: "",    null: false
    t.string  "address",      limit: 50,    default: "",    null: false
    t.string  "zipcode",      limit: 16,    default: "",    null: false
    t.string  "site_url",     limit: 100,   default: "",    null: false
    t.string  "question",     limit: 50,    default: "",    null: false
    t.string  "answer",       limit: 50,    default: "",    null: false
    t.string  "reg_ip",       limit: 25,    default: "0",   null: false
    t.string  "facebook",     limit: 255,                   null: false
    t.string  "mssv",         limit: 255,                   null: false
    t.integer "school_id",    limit: 4,                     null: false
    t.string  "department",   limit: 500,                   null: false
    t.string  "class_tmp",    limit: 500,                   null: false
    t.text    "intro",        limit: 65535,                 null: false
  end

  create_table "pb_membergroups", id: false, force: :cascade do |t|
    t.integer "id",                limit: 2,                             null: false
    t.boolean "membertype_id",                   default: false,         null: false
    t.string  "name",              limit: 50,    default: "",            null: false
    t.text    "description",       limit: 65535
    t.string  "type",              limit: 7,     default: "define",      null: false
    t.string  "system",            limit: 7,     default: "private",     null: false
    t.string  "picture",           limit: 50,    default: "default.gif", null: false
    t.integer "point_max",         limit: 2,     default: 0,             null: false
    t.integer "point_min",         limit: 2,     default: 0,             null: false
    t.integer "max_offer",         limit: 2,     default: 0,             null: false
    t.integer "max_product",       limit: 2,     default: 0,             null: false
    t.integer "max_job",           limit: 2,     default: 0,             null: false
    t.integer "max_companynews",   limit: 2,     default: 0,             null: false
    t.integer "max_producttype",   limit: 2,     default: 3,             null: false
    t.integer "max_album",         limit: 2,     default: 0,             null: false
    t.integer "max_attach_size",   limit: 2,     default: 0,             null: false
    t.integer "max_size_perday",   limit: 2,     default: 0,             null: false
    t.integer "max_favorite",      limit: 2,     default: 0,             null: false
    t.boolean "is_default",                      default: false,         null: false
    t.boolean "allow_offer",                     default: false,         null: false
    t.boolean "allow_market",                    default: false,         null: false
    t.boolean "allow_company",                   default: false,         null: false
    t.boolean "allow_product",                   default: false,         null: false
    t.boolean "allow_job",                       default: false,         null: false
    t.boolean "allow_companynews",               default: true,          null: false
    t.boolean "allow_album",                     default: false,         null: false
    t.boolean "allow_space",                     default: true,          null: false
    t.boolean "default_live_time",               default: true,          null: false
    t.boolean "after_live_time",                 default: true,          null: false
    t.boolean "exempt",                          default: false,         null: false
    t.integer "created",           limit: 4,     default: 0,             null: false
    t.integer "modified",          limit: 4,     default: 0,             null: false
  end

  create_table "pb_membermembertypes", id: false, force: :cascade do |t|
    t.integer  "id",            limit: 4, null: false
    t.integer  "member_id",     limit: 4, null: false
    t.integer  "membertype_id", limit: 4, null: false
    t.datetime "created",                 null: false
  end

  create_table "pb_members", id: false, force: :cascade do |t|
    t.integer  "id",                        limit: 4,                   null: false
    t.string   "space_name",                limit: 255,   default: "",  null: false
    t.integer  "templet_id",                limit: 2,     default: 0,   null: false
    t.string   "username",                  limit: 25,    default: "",  null: false
    t.string   "userpass",                  limit: 50,    default: "",  null: false
    t.string   "email",                     limit: 100,   default: "",  null: false
    t.integer  "points",                    limit: 2,     default: 0,   null: false
    t.integer  "credits",                   limit: 2,     default: 0,   null: false
    t.float    "balance_amount",            limit: 24,    default: 0.0, null: false
    t.string   "trusttype_ids",             limit: 25,    default: "",  null: false
    t.string   "status",                    limit: 1,     default: "0", null: false
    t.string   "photo",                     limit: 100,   default: "",  null: false
    t.integer  "membertype_id",             limit: 2,     default: 0,   null: false
    t.integer  "membergroup_id",            limit: 2,     default: 0,   null: false
    t.string   "last_login",                limit: 11,    default: "0", null: false
    t.string   "last_ip",                   limit: 25,    default: "0", null: false
    t.string   "service_start_date",        limit: 11,    default: "0", null: false
    t.string   "service_end_date",          limit: 11,    default: "0", null: false
    t.integer  "office_redirect",           limit: 2,     default: 0,   null: false
    t.string   "created",                   limit: 10,    default: "0", null: false
    t.string   "modified",                  limit: 10,    default: "0", null: false
    t.integer  "referrer_id",               limit: 4
    t.integer  "checkout",                  limit: 4,     default: 0,   null: false
    t.integer  "level1_point",              limit: 4,     default: 0,   null: false
    t.integer  "level2_point",              limit: 4,     default: 0,   null: false
    t.integer  "level1_paid",               limit: 4,     default: 0,   null: false
    t.integer  "level2_paid",               limit: 4,     default: 0,   null: false
    t.integer  "current_type",              limit: 4,                   null: false
    t.text     "studypictures",             limit: 65535,               null: false
    t.integer  "counted_effective_members", limit: 4,     default: 0,   null: false
    t.string   "role",                      limit: 255,                 null: false
    t.string   "typing",                    limit: 255,                 null: false
    t.string   "typing_time",               limit: 255,                 null: false
    t.text     "fb_app_id",                 limit: 65535,               null: false
    t.text     "fb_secret",                 limit: 65535,               null: false
    t.text     "fb_access_token",           limit: 65535,               null: false
    t.text     "fb_code",                   limit: 65535,               null: false
    t.text     "fb_data",                   limit: 65535,               null: false
    t.text     "fb_user_id",                limit: 65535,               null: false
    t.integer  "connect_points",            limit: 4,     default: 0,   null: false
    t.integer  "good_shop_status",          limit: 4,     default: 0,   null: false
    t.integer  "good_shop_moderator",       limit: 4,     default: 0,   null: false
    t.datetime "good_shop_date"
    t.integer  "active_time",               limit: 4,     default: 0,   null: false
    t.datetime "active_last",                                           null: false
    t.integer  "points_monthly",            limit: 4,     default: 0,   null: false
    t.integer  "points_storage",            limit: 4,     default: 0,   null: false
    t.datetime "points_storage_updated"
    t.integer  "points_monthly_lock",       limit: 4,     default: 0,   null: false
    t.integer  "logging_count",             limit: 4,     default: 0,   null: false
    t.integer  "points_weekly",             limit: 4,     default: 0,   null: false
    t.integer  "points_weekly_store",       limit: 4,     default: 0,   null: false
    t.datetime "points_weekly_updated"
    t.integer  "activity_announce_count",   limit: 4,     default: 0,   null: false
    t.integer  "area_show",                 limit: 4,     default: 1,   null: false
    t.integer  "area_moderator",            limit: 4,     default: 0,   null: false
  end

  create_table "pb_membertypes", id: false, force: :cascade do |t|
    t.integer "id",                     limit: 2,                  null: false
    t.integer "default_membergroup_id", limit: 2,     default: 0,  null: false
    t.string  "name",                   limit: 50,    default: "", null: false
    t.text    "description",            limit: 65535
  end

  create_table "pb_messages", id: false, force: :cascade do |t|
    t.integer "id",                  limit: 4,                      null: false
    t.string  "type",                limit: 7,     default: "user", null: false
    t.integer "from_member_id",      limit: 4,     default: -1,     null: false
    t.string  "cache_from_username", limit: 25,    default: "",     null: false
    t.integer "to_member_id",        limit: 4,     default: -1,     null: false
    t.string  "cache_to_username",   limit: 25,    default: "",     null: false
    t.string  "title",               limit: 255,   default: "",     null: false
    t.text    "content",             limit: 65535
    t.boolean "status",                            default: false,  null: false
    t.integer "created",             limit: 4,     default: 0,      null: false
    t.integer "announce",            limit: 4,     default: 0,      null: false
    t.string  "membertype_ids",      limit: 255,                    null: false
  end

  create_table "pb_metas", id: false, force: :cascade do |t|
    t.integer "id",          limit: 4,                null: false
    t.integer "object_id",   limit: 4,   default: 0,  null: false
    t.string  "object_type", limit: 100, default: "", null: false
    t.text    "content",     limit: 255,              null: false
  end

  create_table "pb_moderators", id: false, force: :cascade do |t|
    t.integer  "id",                limit: 4,     null: false
    t.integer  "member_id",         limit: 4,     null: false
    t.text     "manage_types",      limit: 65535, null: false
    t.text     "manage_industries", limit: 65535, null: false
    t.integer  "status",            limit: 4,     null: false
    t.text     "rights",            limit: 65535, null: false
    t.datetime "created",                         null: false
  end

  create_table "pb_modlogs", id: false, force: :cascade do |t|
    t.integer  "id",              limit: 4,     null: false
    t.string   "type",            limit: 255,   null: false
    t.integer  "valid_status",    limit: 4,     null: false
    t.text     "valid_message",   limit: 65535, null: false
    t.integer  "valid_moderator", limit: 4,     null: false
    t.datetime "valid_date",                    null: false
    t.integer  "item_id",         limit: 4,     null: false
  end

  create_table "pb_navs", id: false, force: :cascade do |t|
    t.integer "id",            limit: 2,                     null: false
    t.integer "parent_id",     limit: 2,   default: 0,       null: false
    t.string  "name",          limit: 50,  default: "",      null: false
    t.string  "description",   limit: 255, default: "",      null: false
    t.string  "url",           limit: 255, default: "",      null: false
    t.string  "target",        limit: 6,   default: "_self", null: false
    t.boolean "status",                    default: true,    null: false
    t.integer "display_order", limit: 2,   default: 0,       null: false
    t.boolean "highlight",                 default: false,   null: false
    t.boolean "level",                     default: false,   null: false
    t.string  "class_name",    limit: 25,  default: "",      null: false
    t.integer "created",       limit: 4,   default: 0,       null: false
    t.integer "modified",      limit: 4,   default: 0,       null: false
  end

  create_table "pb_newses", id: false, force: :cascade do |t|
    t.integer  "id",                 limit: 4,                     null: false
    t.integer  "type_id",            limit: 2,     default: 0,     null: false
    t.boolean  "type",                             default: false, null: false
    t.integer  "industry_id",        limit: 2,     default: 0,     null: false
    t.integer  "area_id",            limit: 2,     default: 0,     null: false
    t.string   "title",              limit: 255,   default: "",    null: false
    t.text     "content",            limit: 65535
    t.string   "source",             limit: 25,    default: "",    null: false
    t.string   "picture",            limit: 50,    default: "",    null: false
    t.boolean  "if_focus",                         default: false, null: false
    t.boolean  "if_commend",                       default: false, null: false
    t.boolean  "highlight",                        default: false, null: false
    t.integer  "clicked",            limit: 4,     default: 1,     null: false
    t.boolean  "status",                           default: true,  null: false
    t.boolean  "flag",                             default: false, null: false
    t.string   "require_membertype", limit: 15,    default: "0",   null: false
    t.string   "tag_ids",            limit: 255,   default: ""
    t.integer  "created",            limit: 4,     default: 0,     null: false
    t.datetime "create_time",                                      null: false
    t.date     "start_time",                                       null: false
    t.date     "end_time",                                         null: false
    t.integer  "modified",           limit: 4,     default: 0,     null: false
    t.text     "clicked_logs",       limit: 65535
  end

  create_table "pb_newstypes", id: false, force: :cascade do |t|
    t.integer "id",        limit: 2,                 null: false
    t.string  "name",      limit: 25, default: "",   null: false
    t.boolean "level_id",             default: true, null: false
    t.boolean "status",               default: true, null: false
    t.integer "parent_id", limit: 2,  default: 0,    null: false
    t.integer "created",   limit: 4,  default: 0,    null: false
  end

  create_table "pb_ordergoods", id: false, force: :cascade do |t|
    t.integer "goods_id", limit: 2,  default: 0,  null: false
    t.integer "order_id", limit: 2,  default: 0,  null: false
    t.string  "trade_no", limit: 16, default: "", null: false
    t.integer "amount",   limit: 2,  default: 1,  null: false
  end

  create_table "pb_orders", id: false, force: :cascade do |t|
    t.integer "id",             limit: 2,                     null: false
    t.string  "trade_no",       limit: 16,    default: "",    null: false
    t.integer "member_id",      limit: 4,     default: -1,    null: false
    t.boolean "anonymous",                    default: false, null: false
    t.string  "cache_username", limit: 25,    default: "",    null: false
    t.float   "total_price",    limit: 24,    default: 0.0,   null: false
    t.string  "subject",        limit: 100,   default: "",    null: false
    t.text    "content",        limit: 65535
    t.boolean "pay_status",                   default: false, null: false
    t.boolean "status",                       default: false, null: false
    t.integer "pay_id",         limit: 2,     default: 0,     null: false
    t.string  "pay_name",       limit: 25,    default: "",    null: false
    t.integer "created",        limit: 4,     default: 0,     null: false
    t.integer "modified",       limit: 4,     default: 0,     null: false
  end

  create_table "pb_passports", id: false, force: :cascade do |t|
    t.integer "id",          limit: 2,                    null: false
    t.string  "name",        limit: 25,    default: "",   null: false
    t.string  "title",       limit: 25,    default: "",   null: false
    t.text    "description", limit: 65535
    t.string  "url",         limit: 25,    default: "",   null: false
    t.text    "config",      limit: 65535
    t.boolean "available",                 default: true, null: false
    t.integer "created",     limit: 4,     default: 0,    null: false
    t.integer "modified",    limit: 4,     default: 0,    null: false
  end

  create_table "pb_payhistories", id: false, force: :cascade do |t|
    t.integer "id",         limit: 4,                 null: false
    t.integer "member_id",  limit: 4,  default: -1,   null: false
    t.string  "trade_no",   limit: 25, default: "-1", null: false
    t.float   "amount",     limit: 24, default: 0.0,  null: false
    t.float   "remain",     limit: 24, default: 0.0,  null: false
    t.string  "ip_address", limit: 15, default: "1",  null: false
    t.integer "created",    limit: 4,  default: 0,    null: false
    t.integer "modified",   limit: 4,  default: 0,    null: false
  end

  create_table "pb_payments", id: false, force: :cascade do |t|
    t.integer "id",                limit: 2,                     null: false
    t.string  "name",              limit: 25,    default: "",    null: false
    t.string  "title",             limit: 25,    default: "",    null: false
    t.text    "description",       limit: 65535
    t.text    "config",            limit: 65535
    t.boolean "available",                       default: true,  null: false
    t.boolean "if_online_support",               default: false, null: false
    t.integer "created",           limit: 4,     default: 0,     null: false
    t.integer "modified",          limit: 4,     default: 0,     null: false
  end

  create_table "pb_personals", id: false, force: :cascade do |t|
    t.integer "member_id",     limit: 4, default: -1,    null: false
    t.boolean "resume_status",           default: false, null: false
    t.boolean "max_education",           default: false, null: false
  end

  create_table "pb_plugins", id: false, force: :cascade do |t|
    t.integer "id",          limit: 2,                    null: false
    t.string  "name",        limit: 25,    default: "",   null: false
    t.string  "title",       limit: 25,    default: "",   null: false
    t.text    "description", limit: 65535
    t.string  "copyright",   limit: 25,    default: "",   null: false
    t.string  "version",     limit: 15,    default: "",   null: false
    t.text    "pluginvar",   limit: 65535
    t.boolean "available",                 default: true, null: false
    t.integer "created",     limit: 4,     default: 0,    null: false
    t.integer "modified",    limit: 4,     default: 0,    null: false
  end

  create_table "pb_pointlogs", id: false, force: :cascade do |t|
    t.integer "id",          limit: 4,                  null: false
    t.integer "member_id",   limit: 4,     default: -1, null: false
    t.string  "action_name", limit: 25,    default: "", null: false
    t.integer "points",      limit: 2,     default: 0,  null: false
    t.text    "description", limit: 65535
    t.string  "ip_address",  limit: 15,    default: "", null: false
    t.integer "created",     limit: 4,     default: 0,  null: false
    t.integer "modified",    limit: 4,     default: 0,  null: false
  end

  create_table "pb_productads", id: false, force: :cascade do |t|
    t.integer  "id",               limit: 4,             null: false
    t.integer  "product_id",       limit: 4,             null: false
    t.integer  "productadtype_id", limit: 4,             null: false
    t.datetime "created",                                null: false
    t.integer  "order",            limit: 4, default: 0, null: false
  end

  create_table "pb_productadtypes", id: false, force: :cascade do |t|
    t.integer "id",   limit: 4,     null: false
    t.text    "name", limit: 65535, null: false
  end

  create_table "pb_productcategories", id: false, force: :cascade do |t|
    t.integer "id",            limit: 2,                   null: false
    t.integer "parent_id",     limit: 2,   default: 0,     null: false
    t.boolean "level",                     default: true,  null: false
    t.string  "name",          limit: 255, default: "",    null: false
    t.boolean "display_order",             default: false, null: false
  end

  create_table "pb_productcomments", id: false, force: :cascade do |t|
    t.integer  "id",          limit: 4,     null: false
    t.integer  "member_id",   limit: 4,     null: false
    t.integer  "company_id",  limit: 4,     null: false
    t.integer  "product_id",  limit: 4,     null: false
    t.text     "content",     limit: 65535, null: false
    t.datetime "created",                   null: false
    t.string   "guest_name",  limit: 255,   null: false
    t.string   "guest_email", limit: 255,   null: false
  end

  create_table "pb_productprices", id: false, force: :cascade do |t|
    t.integer "id",           limit: 4,                     null: false
    t.boolean "type_id",                    default: true,  null: false
    t.integer "product_id",   limit: 4,     default: -1,    null: false
    t.integer "brand_id",     limit: 2,     default: -1,    null: false
    t.integer "member_id",    limit: 4,     default: -1,    null: false
    t.integer "company_id",   limit: 4,     default: -1,    null: false
    t.integer "area_id",      limit: 2,     default: 0,     null: false
    t.boolean "price_trends",               default: false, null: false
    t.integer "category_id",  limit: 2,     default: 0,     null: false
    t.string  "source",       limit: 255,   default: "",    null: false
    t.string  "title",        limit: 255,   default: "",    null: false
    t.text    "description",  limit: 65535,                 null: false
    t.boolean "units",                      default: true,  null: false
    t.boolean "currency",                   default: true,  null: false
    t.float   "price",        limit: 24,    default: 0.0,   null: false
    t.integer "created",      limit: 4,     default: 0,     null: false
    t.integer "modified",     limit: 4,     default: 0,     null: false
  end

  create_table "pb_products", id: false, force: :cascade do |t|
    t.integer  "id",                              limit: 4,                     null: false
    t.integer  "member_id",                       limit: 4,     default: -1,    null: false
    t.integer  "company_id",                      limit: 4,     default: 0,     null: false
    t.string   "cache_companyname",               limit: 100,   default: "",    null: false
    t.boolean  "sort_id",                                       default: true,  null: false
    t.integer  "brand_id",                        limit: 2,     default: 0,     null: false
    t.integer  "category_id",                     limit: 2,     default: 0,     null: false
    t.integer  "industry_id",                     limit: 2,     default: 0,     null: false
    t.integer  "country_id",                      limit: 2,     default: 0,     null: false
    t.integer  "area_id",                         limit: 2,     default: 0,     null: false
    t.string   "name",                            limit: 255,   default: "",    null: false
    t.float    "price",                           limit: 24,    default: 0.0,   null: false
    t.string   "sn",                              limit: 20,    default: "",    null: false
    t.string   "spec",                            limit: 20,    default: "",    null: false
    t.string   "produce_area",                    limit: 50,    default: "",    null: false
    t.string   "packing_content",                 limit: 100,   default: "",    null: false
    t.string   "picture",                         limit: 255,   default: "",    null: false
    t.text     "content",                         limit: 65535
    t.integer  "producttype_id",                  limit: 2,     default: 0,     null: false
    t.boolean  "status",                                        default: false, null: false
    t.boolean  "state",                                         default: true,  null: false
    t.boolean  "ifnew",                                         default: false, null: false
    t.boolean  "ifcommend",                                     default: false, null: false
    t.boolean  "priority",                                      default: false, null: false
    t.string   "tag_ids",                         limit: 255,   default: ""
    t.integer  "clicked",                         limit: 2,     default: 1,     null: false
    t.text     "formattribute_ids",               limit: 65535
    t.integer  "created",                         limit: 4,     default: 0,     null: false
    t.integer  "modified",                        limit: 4,     default: 0,     null: false
    t.string   "picture1",                        limit: 255
    t.string   "picture2",                        limit: 255
    t.string   "picture3",                        limit: 255
    t.string   "picture4",                        limit: 255
    t.string   "tempurl",                         limit: 255
    t.integer  "default_pic",                     limit: 4,     default: 0,     null: false
    t.string   "price_note",                      limit: 255
    t.integer  "service",                         limit: 4,     default: 0,     null: false
    t.float    "new_price",                       limit: 24
    t.string   "price_unit",                      limit: 255
    t.integer  "order",                           limit: 4,     default: 0,     null: false
    t.string   "product_code",                    limit: 255
    t.text     "market",                          limit: 65535
    t.text     "clicked_logs",                    limit: 65535
    t.integer  "show",                            limit: 4,     default: 1,     null: false
    t.integer  "ads",                             limit: 4,     default: 0,     null: false
    t.datetime "ads_time",                                                      null: false
    t.integer  "top_new_product_main_featured",   limit: 4,     default: 0,     null: false
    t.integer  "facebook_pubstatus",              limit: 4,     default: 0,     null: false
    t.integer  "facebook_pubstatus_user",         limit: 4,     default: 0,     null: false
    t.integer  "facebook_pubstatus_user_wall",    limit: 4,     default: 0,     null: false
    t.text     "facebook_pubstatus_user_fanpage", limit: 65535,                 null: false
    t.integer  "facebook_pubstatus_fanpage",      limit: 4,     default: 0,     null: false
    t.integer  "valid_status",                    limit: 4,     default: 1,     null: false
    t.text     "valid_message",                   limit: 65535,                 null: false
    t.integer  "valid_moderator",                 limit: 4,                     null: false
    t.datetime "valid_date",                                                    null: false
    t.integer  "area_show",                       limit: 4,     default: 1,     null: false
    t.integer  "display_type",                    limit: 4,     default: 0,     null: false
    t.integer  "for_student",                     limit: 4,     default: 0,     null: false
    t.integer  "mobile_home",                     limit: 4,     default: 0,     null: false
  end

  create_table "pb_productsorts", id: false, force: :cascade do |t|
    t.integer "id",            limit: 2,                   null: false
    t.string  "name",          limit: 255, default: "",    null: false
    t.boolean "display_order",             default: false, null: false
  end

  create_table "pb_producttypes", id: false, force: :cascade do |t|
    t.integer "id",                        limit: 4,                  null: false
    t.integer "member_id",                 limit: 4,  default: -1,    null: false
    t.integer "company_id",                limit: 4,  default: -1,    null: false
    t.string  "name",                      limit: 25, default: "",    null: false
    t.boolean "level",                                default: false, null: false
    t.integer "created",                   limit: 4,  default: 0,     null: false
    t.integer "modified",                  limit: 4,  default: 0,     null: false
    t.integer "parent_industry_id",        limit: 4,  default: 0
    t.integer "custom_parent_industry_id", limit: 4,  default: 0,     null: false
  end

  create_table "pb_quotes", id: false, force: :cascade do |t|
    t.integer "id",         limit: 2,                    null: false
    t.integer "product_id", limit: 4,     default: -1,   null: false
    t.integer "market_id",  limit: 2,     default: -1,   null: false
    t.integer "type_id",    limit: 2,     default: 0,    null: false
    t.string  "title",      limit: 255,   default: "",   null: false
    t.text    "content",    limit: 65535,                null: false
    t.integer "area_id",    limit: 2,     default: 0,    null: false
    t.integer "area_id1",   limit: 2,     default: 0,    null: false
    t.integer "area_id2",   limit: 2,     default: 0,    null: false
    t.integer "area_id3",   limit: 2,     default: 0,    null: false
    t.float   "max_price",  limit: 24,    default: 0.0,  null: false
    t.float   "min_price",  limit: 24,    default: 0.0,  null: false
    t.boolean "units",                    default: true, null: false
    t.boolean "currency",                 default: true, null: false
    t.text    "trend_data", limit: 65535,                null: false
    t.integer "hits",       limit: 4,     default: 1,    null: false
    t.integer "created",    limit: 4,     default: 0,    null: false
    t.integer "modified",   limit: 4,     default: 0,    null: false
  end

  create_table "pb_quotetypes", id: false, force: :cascade do |t|
    t.integer "id",            limit: 2,                   null: false
    t.integer "parent_id",     limit: 2,   default: 0,     null: false
    t.boolean "level",                     default: true,  null: false
    t.string  "name",          limit: 255, default: "",    null: false
    t.boolean "display_order",             default: false, null: false
  end

  create_table "pb_roleadminers", id: false, force: :cascade do |t|
    t.integer "id",           limit: 4, null: false
    t.integer "adminrole_id", limit: 4
    t.integer "adminer_id",   limit: 4
  end

  create_table "pb_roleprivileges", id: false, force: :cascade do |t|
    t.integer "id",                limit: 4, null: false
    t.integer "adminrole_id",      limit: 4
    t.integer "adminprivilege_id", limit: 4
  end

  create_table "pb_saleorderitems", id: false, force: :cascade do |t|
    t.integer "id",           limit: 4,   null: false
    t.integer "saleorder_id", limit: 4
    t.integer "product_id",   limit: 4
    t.string  "price",        limit: 255
    t.integer "quantity",     limit: 4
  end

  create_table "pb_saleorders", id: false, force: :cascade do |t|
    t.integer "id",                  limit: 4,                 null: false
    t.integer "buyer_id",            limit: 4
    t.integer "seller_id",           limit: 4
    t.string  "fullname",            limit: 255
    t.string  "email",               limit: 255
    t.string  "mobile",              limit: 50
    t.integer "country_id",          limit: 4
    t.integer "area_id",             limit: 4
    t.string  "address",             limit: 255
    t.string  "receiver_fullname",   limit: 255
    t.string  "receiver_mobile",     limit: 255
    t.string  "receiver_email",      limit: 255
    t.integer "receiver_country_id", limit: 4
    t.integer "receiver_area_id",    limit: 4
    t.string  "receiver_address",    limit: 255
    t.text    "message",             limit: 65535
    t.string  "status",              limit: 255
    t.integer "created",             limit: 4
    t.integer "read",                limit: 4,     default: 0, null: false
  end

  create_table "pb_schoolimagecomments", id: false, force: :cascade do |t|
    t.integer "id",             limit: 4,     null: false
    t.integer "schoolimage_id", limit: 4,     null: false
    t.integer "member_id",      limit: 4,     null: false
    t.text    "content",        limit: 65535, null: false
    t.text    "created",        limit: 65535, null: false
  end

  create_table "pb_schoolimages", id: false, force: :cascade do |t|
    t.integer  "id",          limit: 4,     null: false
    t.integer  "school_id",   limit: 4,     null: false
    t.string   "name",        limit: 255,   null: false
    t.text     "description", limit: 65535, null: false
    t.datetime "created",                   null: false
  end

  create_table "pb_schools", id: false, force: :cascade do |t|
    t.integer "id",          limit: 4,                 null: false
    t.text    "name",        limit: 65535
    t.text    "description", limit: 65535
    t.string  "address",     limit: 500,               null: false
    t.string  "phone",       limit: 255,               null: false
    t.string  "email",       limit: 255,               null: false
    t.string  "website",     limit: 255,               null: false
    t.string  "logo",        limit: 255,               null: false
    t.string  "banner",      limit: 255,               null: false
    t.integer "created",     limit: 4
    t.integer "area_id",     limit: 4,                 null: false
    t.integer "leader_id",   limit: 4,                 null: false
    t.integer "member_id",   limit: 4,                 null: false
    t.integer "area_show",   limit: 4,     default: 1, null: false
  end

  create_table "pb_services", id: false, force: :cascade do |t|
    t.integer "id",             limit: 2,                     null: false
    t.integer "member_id",      limit: 4,     default: -1,    null: false
    t.string  "title",          limit: 25,    default: "",    null: false
    t.text    "content",        limit: 65535
    t.string  "nick_name",      limit: 25,    default: ""
    t.string  "email",          limit: 25,    default: "",    null: false
    t.string  "user_ip",        limit: 11,    default: "",    null: false
    t.boolean "type_id",                      default: false, null: false
    t.boolean "status",                       default: false, null: false
    t.integer "created",        limit: 4,     default: 0,     null: false
    t.integer "modified",       limit: 4,     default: 0,     null: false
    t.text    "revert_content", limit: 65535
    t.integer "revert_date",    limit: 4,     default: 0,     null: false
  end

  create_table "pb_sessions", id: false, force: :cascade do |t|
    t.string  "sesskey",   limit: 50,    default: "", null: false
    t.integer "expiry",    limit: 4,     default: 0,  null: false
    t.string  "expireref", limit: 64,    default: "", null: false
    t.text    "data",      limit: 65535
    t.integer "created",   limit: 4,     default: 0,  null: false
    t.integer "modified",  limit: 4,     default: 0,  null: false
  end

  create_table "pb_settings", id: false, force: :cascade do |t|
    t.integer "id",       limit: 2,                     null: false
    t.boolean "type_id",                default: false, null: false
    t.string  "variable", limit: 150,   default: "",    null: false
    t.text    "valued",   limit: 65535
  end

  create_table "pb_shopvotes", id: false, force: :cascade do |t|
    t.integer  "id",         limit: 4, null: false
    t.integer  "member_id",  limit: 4, null: false
    t.integer  "company_id", limit: 4, null: false
    t.integer  "rate",       limit: 4, null: false
    t.datetime "created",              null: false
  end

  create_table "pb_spacecaches", id: false, force: :cascade do |t|
    t.string  "cache_spacename", limit: 255,   default: "", null: false
    t.integer "company_id",      limit: 4,     default: -1, null: false
    t.text    "data1",           limit: 65535,              null: false
    t.text    "data2",           limit: 65535,              null: false
    t.integer "expiration",      limit: 4,     default: 0,  null: false
  end

  create_table "pb_spacelinks", id: false, force: :cascade do |t|
    t.integer "id",            limit: 4,                   null: false
    t.integer "member_id",     limit: 4,   default: 0,     null: false
    t.integer "company_id",    limit: 4,   default: 0,     null: false
    t.integer "display_order", limit: 2,   default: 0,     null: false
    t.string  "title",         limit: 100, default: "",    null: false
    t.string  "url",           limit: 255, default: "",    null: false
    t.boolean "is_outlink",                default: false, null: false
    t.string  "description",   limit: 100, default: "",    null: false
    t.string  "logo",          limit: 255, default: "",    null: false
    t.boolean "highlight",                 default: false, null: false
    t.integer "created",       limit: 4,   default: 0,     null: false
  end

  create_table "pb_sponsors", id: false, force: :cascade do |t|
    t.integer  "id",               limit: 4,     null: false
    t.integer  "company_id",       limit: 4,     null: false
    t.text     "name",             limit: 65535, null: false
    t.integer  "area_id",          limit: 4,     null: false
    t.text     "address",          limit: 65535, null: false
    t.string   "phone",            limit: 255,   null: false
    t.string   "fax",              limit: 255,   null: false
    t.string   "email",            limit: 255,   null: false
    t.string   "website",          limit: 255,   null: false
    t.string   "contact_name",     limit: 255,   null: false
    t.string   "contact_mobile",   limit: 255,   null: false
    t.string   "contact_position", limit: 255,   null: false
    t.string   "contact_email",    limit: 255,   null: false
    t.text     "facebook",         limit: 65535, null: false
    t.text     "facebook_fanpage", limit: 65535, null: false
    t.datetime "created",                        null: false
    t.string   "types",            limit: 255,   null: false
    t.text     "logo",             limit: 65535, null: false
  end

  create_table "pb_spreadadses", id: false, force: :cascade do |t|
    t.integer "id",         limit: 4,                null: false
    t.integer "member_id",  limit: 4,   default: 0,  null: false
    t.string  "title",      limit: 250, default: "", null: false
    t.string  "desc1",      limit: 200, default: "", null: false
    t.string  "desc2",      limit: 200, default: "", null: false
    t.string  "show_url",   limit: 100, default: "", null: false
    t.string  "target_url", limit: 100, default: "", null: false
    t.integer "created",    limit: 4,   default: 0,  null: false
    t.integer "modified",   limit: 4,   default: 0,  null: false
  end

  create_table "pb_spreadadstypes", id: false, force: :cascade do |t|
    t.integer "id",        limit: 4,                null: false
    t.integer "member_id", limit: 4,   default: 0,  null: false
    t.string  "name",      limit: 250, default: "", null: false
    t.integer "created",   limit: 4,   default: 0,  null: false
    t.integer "modified",  limit: 4,   default: 0,  null: false
  end

  create_table "pb_spreads", id: false, force: :cascade do |t|
    t.integer "id",             limit: 4,                   null: false
    t.integer "member_id",      limit: 4,   default: -1,    null: false
    t.string  "keyword_name",   limit: 25,  default: "",    null: false
    t.string  "title",          limit: 50,  default: "",    null: false
    t.string  "content",        limit: 200, default: "",    null: false
    t.string  "target_url",     limit: 100, default: "",    null: false
    t.integer "hits",           limit: 4,   default: 1,     null: false
    t.boolean "status",                     default: false, null: false
    t.integer "expiration",     limit: 4,   default: 0,     null: false
    t.integer "show_times",     limit: 4,   default: 1,     null: false
    t.float   "cost_every_hit", limit: 24,  default: 0.0,   null: false
    t.boolean "display_order",              default: false, null: false
    t.integer "created",        limit: 4,   default: 0,     null: false
  end

  create_table "pb_standards", id: false, force: :cascade do |t|
    t.integer "id",            limit: 2,                  null: false
    t.integer "attachment_id", limit: 2,     default: 0,  null: false
    t.integer "type_id",       limit: 2,     default: 0,  null: false
    t.string  "title",         limit: 255,   default: "", null: false
    t.string  "source",        limit: 255,   default: "", null: false
    t.string  "digest",        limit: 255,   default: "", null: false
    t.text    "content",       limit: 65535,              null: false
    t.integer "publish_time",  limit: 4,     default: 0,  null: false
    t.integer "force_time",    limit: 4,     default: 0,  null: false
    t.integer "clicked",       limit: 2,     default: 1,  null: false
    t.integer "created",       limit: 4,     default: 0,  null: false
    t.integer "modified",      limit: 4,     default: 0,  null: false
  end

  create_table "pb_standardtypes", id: false, force: :cascade do |t|
    t.integer "id",            limit: 2,                   null: false
    t.string  "name",          limit: 100, default: "",    null: false
    t.boolean "display_order",             default: false, null: false
  end

  create_table "pb_studyfollows", id: false, force: :cascade do |t|
    t.integer  "id",        limit: 4, null: false
    t.integer  "member_id", limit: 4, null: false
    t.integer  "follow_id", limit: 4, null: false
    t.datetime "created",             null: false
  end

  create_table "pb_studyfriends", id: false, force: :cascade do |t|
    t.integer  "id",        limit: 4,                 null: false
    t.integer  "member_id", limit: 4,                 null: false
    t.integer  "friend_id", limit: 4,                 null: false
    t.datetime "created",                             null: false
    t.text     "message",   limit: 65535,             null: false
    t.integer  "status",    limit: 4,     default: 0, null: false
  end

  create_table "pb_studygroupimagecomments", id: false, force: :cascade do |t|
    t.integer  "id",                 limit: 4,     null: false
    t.integer  "member_id",          limit: 4,     null: false
    t.text     "content",            limit: 65535, null: false
    t.integer  "studygroupimage_id", limit: 4,     null: false
    t.datetime "created",                          null: false
  end

  create_table "pb_studygroupimages", id: false, force: :cascade do |t|
    t.integer  "id",          limit: 4,     null: false
    t.integer  "group_id",    limit: 4,     null: false
    t.string   "name",        limit: 255,   null: false
    t.text     "description", limit: 65535, null: false
    t.datetime "created",                   null: false
  end

  create_table "pb_studygroupmembers", id: false, force: :cascade do |t|
    t.integer "id",            limit: 4, null: false
    t.integer "member_id",     limit: 4, null: false
    t.integer "studygroup_id", limit: 4, null: false
    t.integer "created",       limit: 4, null: false
    t.integer "status",        limit: 4, null: false
  end

  create_table "pb_studygroups", id: false, force: :cascade do |t|
    t.integer "id",           limit: 4,                 null: false
    t.text    "name",         limit: 65535,             null: false
    t.integer "school_id",    limit: 4,                 null: false
    t.integer "subject_id",   limit: 4,                 null: false
    t.integer "created",      limit: 4,                 null: false
    t.integer "member_id",    limit: 4,                 null: false
    t.string  "logo",         limit: 255,               null: false
    t.string  "banner",       limit: 255,               null: false
    t.integer "leader_id",    limit: 4,                 null: false
    t.integer "pinned",       limit: 4,                 null: false
    t.text    "announce",     limit: 65535,             null: false
    t.text    "intro",        limit: 65535,             null: false
    t.text    "event",        limit: 65535,             null: false
    t.integer "area_show",    limit: 4,     default: 1, null: false
    t.integer "clicked",      limit: 4,                 null: false
    t.text    "clicked_logs", limit: 65535,             null: false
  end

  create_table "pb_studygroupviews", id: false, force: :cascade do |t|
    t.integer  "id",            limit: 4, null: false
    t.integer  "studygroup_id", limit: 4, null: false
    t.integer  "member_id",     limit: 4, null: false
    t.datetime "created",                 null: false
  end

  create_table "pb_studymemberimagecomments", id: false, force: :cascade do |t|
    t.integer  "id",                  limit: 4,     null: false
    t.integer  "studymemberimage_id", limit: 4,     null: false
    t.integer  "member_id",           limit: 4,     null: false
    t.text     "content",             limit: 65535, null: false
    t.datetime "created",                           null: false
  end

  create_table "pb_studymemberimages", id: false, force: :cascade do |t|
    t.integer  "id",          limit: 4,     null: false
    t.integer  "member_id",   limit: 4,     null: false
    t.string   "name",        limit: 255,   null: false
    t.datetime "created",                   null: false
    t.text     "description", limit: 65535, null: false
  end

  create_table "pb_studypostcomments", id: false, force: :cascade do |t|
    t.integer  "id",           limit: 4,     null: false
    t.integer  "studypost_id", limit: 4,     null: false
    t.text     "content",      limit: 65535, null: false
    t.integer  "star",         limit: 4,     null: false
    t.datetime "created",                    null: false
    t.datetime "modified",                   null: false
    t.integer  "member_id",    limit: 4,     null: false
  end

  create_table "pb_studyposts", id: false, force: :cascade do |t|
    t.integer  "id",                limit: 4,                 null: false
    t.integer  "school_id",         limit: 4,                 null: false
    t.integer  "group_id",          limit: 4,                 null: false
    t.integer  "member_id",         limit: 4,                 null: false
    t.text     "content",           limit: 65535,             null: false
    t.datetime "created",                                     null: false
    t.datetime "modified",                                    null: false
    t.integer  "memberpage_id",     limit: 4,                 null: false
    t.integer  "pinned",            limit: 4,     default: 0, null: false
    t.text     "files",             limit: 65535,             null: false
    t.text     "files_description", limit: 65535,             null: false
  end

  create_table "pb_subjects", id: false, force: :cascade do |t|
    t.integer "id",          limit: 4,     null: false
    t.text    "name",        limit: 65535, null: false
    t.text    "description", limit: 65535, null: false
    t.integer "created",     limit: 4,     null: false
  end

  create_table "pb_tags", id: false, force: :cascade do |t|
    t.integer "id",        limit: 4,                   null: false
    t.integer "member_id", limit: 4,   default: 0,     null: false
    t.string  "name",      limit: 255, default: "",    null: false
    t.integer "numbers",   limit: 2,   default: 0,     null: false
    t.boolean "closed",                default: false, null: false
    t.boolean "flag",                  default: false, null: false
    t.integer "created",   limit: 4,   default: 0,     null: false
    t.integer "modified",  limit: 4,   default: 0,     null: false
  end

  create_table "pb_tasks", id: false, force: :cascade do |t|
    t.integer  "id",            limit: 4,                 null: false
    t.text     "name",          limit: 65535,             null: false
    t.text     "image",         limit: 65535,             null: false
    t.integer  "status",        limit: 4,     default: 0, null: false
    t.text     "note",          limit: 65535,             null: false
    t.datetime "created",                                 null: false
    t.datetime "modified",                                null: false
    t.integer  "display_order", limit: 4,     default: 0, null: false
  end

  create_table "pb_templets", id: false, force: :cascade do |t|
    t.integer "id",                   limit: 2,                        null: false
    t.string  "name",                 limit: 25,    default: "",       null: false
    t.string  "title",                limit: 25,    default: "",       null: false
    t.string  "directory",            limit: 100,   default: "",       null: false
    t.string  "type",                 limit: 6,     default: "system", null: false
    t.string  "author",               limit: 100,   default: "",       null: false
    t.string  "style",                limit: 255,   default: "",       null: false
    t.text    "description",          limit: 65535
    t.boolean "is_default",                         default: false,    null: false
    t.string  "require_membertype",   limit: 100,   default: "0",      null: false
    t.string  "require_membergroups", limit: 100,   default: "0",      null: false
    t.boolean "status",                             default: true,     null: false
  end

  create_table "pb_topicnews", id: false, force: :cascade do |t|
    t.integer "topic_id", limit: 2, default: 0, null: false
    t.integer "news_id",  limit: 2, default: 0, null: false
  end

  create_table "pb_topics", id: false, force: :cascade do |t|
    t.integer "id",          limit: 2,                  null: false
    t.string  "alias_name",  limit: 100,   default: "", null: false
    t.string  "templet",     limit: 100,   default: "", null: false
    t.string  "title",       limit: 255,   default: "", null: false
    t.string  "picture",     limit: 255,   default: "", null: false
    t.text    "description", limit: 65535
    t.integer "created",     limit: 4,     default: 0,  null: false
    t.integer "modified",    limit: 4,     default: 0,  null: false
  end

  create_table "pb_tradecomments", id: false, force: :cascade do |t|
    t.integer  "id",          limit: 4,     null: false
    t.integer  "member_id",   limit: 4,     null: false
    t.integer  "company_id",  limit: 4,     null: false
    t.integer  "trade_id",    limit: 4,     null: false
    t.text     "content",     limit: 65535, null: false
    t.datetime "created",                   null: false
    t.string   "guest_name",  limit: 255,   null: false
    t.string   "guest_email", limit: 255,   null: false
  end

  create_table "pb_tradefields", id: false, force: :cascade do |t|
    t.integer "trade_id",       limit: 4,   default: 0,     null: false
    t.integer "member_id",      limit: 4,   default: 0,     null: false
    t.string  "link_man",       limit: 100, default: "",    null: false
    t.string  "address",        limit: 100, default: "",    null: false
    t.string  "company_name",   limit: 100, default: "",    null: false
    t.string  "email",          limit: 100, default: "",    null: false
    t.boolean "prim_tel",                   default: false, null: false
    t.string  "prim_telnumber", limit: 25,  default: "",    null: false
    t.boolean "prim_im",                    default: false, null: false
    t.string  "prim_imaccount", limit: 100, default: "",    null: false
    t.string  "brand_name",     limit: 50,  default: "",    null: false
    t.string  "template",       limit: 50,  default: "",    null: false
  end

  create_table "pb_trades", id: false, force: :cascade do |t|
    t.integer  "id",                              limit: 4,                     null: false
    t.integer  "type_id",                         limit: 1,     default: 0,     null: false
    t.integer  "industry_id",                     limit: 2,     default: 0,     null: false
    t.integer  "country_id",                      limit: 2,     default: 0,     null: false
    t.integer  "area_id",                         limit: 2,     default: 0,     null: false
    t.integer  "member_id",                       limit: 4,     default: 0,     null: false
    t.integer  "company_id",                      limit: 4,     default: 0,     null: false
    t.string   "cache_username",                  limit: 25,    default: "",    null: false
    t.string   "cache_companyname",               limit: 100,   default: "",    null: false
    t.string   "cache_contacts",                  limit: 255,   default: "",    null: false
    t.string   "title",                           limit: 100,   default: "",    null: false
    t.string   "adwords",                         limit: 125,   default: "",    null: false
    t.text     "content",                         limit: 65535
    t.float    "price",                           limit: 24,    default: 0.0,   null: false
    t.string   "measuring_unit",                  limit: 15,    default: "0",   null: false
    t.string   "monetary_unit",                   limit: 15,    default: "0",   null: false
    t.string   "packing",                         limit: 150,   default: "",    null: false
    t.string   "quantity",                        limit: 25,    default: "",    null: false
    t.boolean  "display_order",                                 default: false, null: false
    t.integer  "display_expiration",              limit: 4,     default: 0,     null: false
    t.string   "spec",                            limit: 200,   default: "",    null: false
    t.string   "sn",                              limit: 25,    default: "",    null: false
    t.string   "picture",                         limit: 50,    default: "",    null: false
    t.string   "picture1",                        limit: 50
    t.string   "picture2",                        limit: 50
    t.string   "picture3",                        limit: 50
    t.string   "picture4",                        limit: 50
    t.string   "picture_remote",                  limit: 50,    default: "",    null: false
    t.integer  "status",                          limit: 1,     default: 0,     null: false
    t.integer  "submit_time",                     limit: 4,     default: 0,     null: false
    t.integer  "expire_time",                     limit: 4,     default: 0,     null: false
    t.integer  "expire_days",                     limit: 4,     default: 10,    null: false
    t.boolean  "if_commend",                                    default: false, null: false
    t.string   "if_urgent",                       limit: 1,     default: "0",   null: false
    t.string   "if_locked",                       limit: 1,     default: "0",   null: false
    t.integer  "require_point",                   limit: 2,     default: 0,     null: false
    t.integer  "require_membertype",              limit: 2,     default: 0,     null: false
    t.integer  "require_freedate",                limit: 4,     default: 0,     null: false
    t.string   "ip_addr",                         limit: 15,    default: "",    null: false
    t.integer  "clicked",                         limit: 4,     default: 1,     null: false
    t.string   "tag_ids",                         limit: 255,   default: "",    null: false
    t.text     "formattribute_ids",               limit: 65535
    t.integer  "highlight",                       limit: 1,     default: 0,     null: false
    t.integer  "created",                         limit: 4,     default: 0,     null: false
    t.integer  "modified",                        limit: 4,     default: 0,     null: false
    t.integer  "brand_id",                        limit: 4,     default: 0,     null: false
    t.string   "market",                          limit: 255
    t.text     "clicked_logs",                    limit: 65535
    t.string   "price_unit",                      limit: 255,                   null: false
    t.integer  "default_pic",                     limit: 4,                     null: false
    t.integer  "facebook_pubstatus",              limit: 4,     default: 0,     null: false
    t.integer  "facebook_pubstatus_user",         limit: 4,     default: 0,     null: false
    t.integer  "facebook_pubstatus_user_wall",    limit: 4,     default: 0,     null: false
    t.text     "facebook_pubstatus_user_fanpage", limit: 65535,                 null: false
    t.integer  "facebook_pubstatus_fanpage",      limit: 4,     default: 0,     null: false
    t.integer  "valid_status",                    limit: 4,     default: 1,     null: false
    t.text     "valid_message",                   limit: 65535,                 null: false
    t.integer  "valid_moderator",                 limit: 4,                     null: false
    t.datetime "valid_date",                                                    null: false
    t.integer  "area_show",                       limit: 4,     default: 1,     null: false
    t.integer  "for_student",                     limit: 4,     default: 0,     null: false
  end

  create_table "pb_tradetypes", id: false, force: :cascade do |t|
    t.integer "id",            limit: 2,                   null: false
    t.integer "parent_id",     limit: 2,   default: 0,     null: false
    t.string  "name",          limit: 25,  default: "",    null: false
    t.boolean "level",                     default: true,  null: false
    t.boolean "display_order",             default: false, null: false
    t.string  "alias_key",     limit: 255,                 null: false
    t.string  "short_name",    limit: 255,                 null: false
  end

  create_table "pb_trustlogs", id: false, force: :cascade do |t|
    t.integer "member_id",    limit: 4,             null: false
    t.integer "trusttype_id", limit: 2, default: 0, null: false
  end

  create_table "pb_trusttypes", id: false, force: :cascade do |t|
    t.integer "id",            limit: 2,                     null: false
    t.string  "name",          limit: 64,    default: "",    null: false
    t.text    "description",   limit: 65535
    t.string  "image",         limit: 255,   default: "",    null: false
    t.boolean "display_order",               default: false, null: false
    t.boolean "status",                      default: true,  null: false
  end

  create_table "pb_typemodels", id: false, force: :cascade do |t|
    t.integer "id",        limit: 2,               null: false
    t.string  "title",     limit: 50, default: "", null: false
    t.string  "type_name", limit: 50, default: "", null: false
  end

  create_table "pb_typeoptions", id: false, force: :cascade do |t|
    t.integer "id",           limit: 2,               null: false
    t.integer "typemodel_id", limit: 2,  default: 0,  null: false
    t.string  "option_value", limit: 50, default: "", null: false
    t.string  "option_label", limit: 50, default: "", null: false
  end

  create_table "pb_userpages", id: false, force: :cascade do |t|
    t.integer "id",            limit: 4,                     null: false
    t.string  "templet_name",  limit: 50,    default: "",    null: false
    t.string  "name",          limit: 50,    default: "",    null: false
    t.string  "title",         limit: 50,    default: "",    null: false
    t.string  "digest",        limit: 50,    default: "",    null: false
    t.text    "content",       limit: 65535
    t.string  "url",           limit: 100,   default: "",    null: false
    t.boolean "display_order",               default: false, null: false
    t.integer "created",       limit: 4,     default: 0,     null: false
    t.integer "modified",      limit: 4,     default: 0,     null: false
  end

  create_table "pb_visitlogs", id: false, force: :cascade do |t|
    t.integer "id",        limit: 2,               null: false
    t.string  "salt",      limit: 32, default: "", null: false
    t.string  "date_line", limit: 15, default: "", null: false
    t.string  "type_name", limit: 15, default: "", null: false
  end

  create_table "pb_words", id: false, force: :cascade do |t|
    t.integer "id",         limit: 2,               null: false
    t.string  "title",      limit: 50, default: "", null: false
    t.string  "replace_to", limit: 50, default: "", null: false
    t.integer "expiration", limit: 4,  default: 0,  null: false
  end

end
