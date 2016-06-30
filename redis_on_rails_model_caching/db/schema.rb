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

ActiveRecord::Schema.define(version: 201305010001002013050100010120130501000102201305010001032013050100010420130501000105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "dblink"
  enable_extension "postgis"

  create_table "active_health_plans_national_lives", id: false, force: :cascade do |t|
    t.integer "health_plan_id"
    t.decimal "lives"
  end

  create_table "active_health_plans_zip_lives", id: false, force: :cascade do |t|
    t.integer "county_id"
    t.string  "county_name",                 limit: 200
    t.integer "county_population"
    t.integer "health_plan_id"
    t.integer "formularyfid"
    t.decimal "county_lives"
    t.integer "county_total_zip_population", limit: 8
    t.string  "zipcode",                     limit: 5
    t.integer "zip_population"
    t.decimal "zip_population_percentage"
    t.decimal "zip_code_lives"
  end

  create_table "address", force: :cascade do |t|
    t.boolean "isactive",                   null: false
    t.string  "address",        limit: 255, null: false
    t.string  "city",           limit: 255, null: false
    t.integer "statefid",                   null: false
    t.string  "postalcode",     limit: 20
    t.integer "addresstypefid",             null: false
    t.string  "address2"
  end

  create_table "addresstype", force: :cascade do |t|
    t.boolean "isactive",             null: false
    t.string  "name",     limit: 255, null: false
  end

  add_index "addresstype", ["name"], name: "addresstype_name_key", unique: true, using: :btree

  create_table "administration_health_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "user_id"
    t.string   "note",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administration_mobile_request_logs", force: :cascade do |t|
    t.string   "udid",            limit: 255
    t.string   "os_version",      limit: 255
    t.string   "application_key", limit: 255
    t.string   "session_key",     limit: 255
    t.string   "device_model",    limit: 255
    t.string   "url",             limit: 1000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administration_mobile_request_logs", ["udid"], name: "index_administration_mobile_request_logs_on_udid", using: :btree

  create_table "administration_mobile_user_sessions", force: :cascade do |t|
    t.string   "session_key",      limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_accessed_at"
  end

  add_index "administration_mobile_user_sessions", ["session_key"], name: "index_administration_mobile_user_sessions_on_session_key", using: :btree
  add_index "administration_mobile_user_sessions", ["user_id"], name: "index_administration_mobile_user_sessions_on_user_id", using: :btree

  create_table "alcon_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "publisher_formulary_name", limit: 255
    t.integer  "publisher_formulary_id"
    t.string   "environment",              limit: 255
    t.string   "file_name",                limit: 255
    t.string   "pdf_unique_id",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alcon_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "alcon_plan_drug_options", ["created_by"], name: "alcon_plan_drug_options_created_by_idx", using: :btree
  add_index "alcon_plan_drug_options", ["updated_by"], name: "alcon_plan_drug_options_updated_by_idx", using: :btree

  create_table "alcon_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "alcon_plan_drug_settings", ["created_by"], name: "alcon_plan_drug_settings_created_by_idx", using: :btree
  add_index "alcon_plan_drug_settings", ["drug_id"], name: "alcon_plan_drug_settings_drug_id_idx", using: :btree
  add_index "alcon_plan_drug_settings", ["healthplan_id"], name: "alcon_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "alcon_plan_drug_settings", ["plan_drug_option_id"], name: "alcon_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "alcon_plan_drug_settings", ["state_id"], name: "alcon_plan_drug_settings_state_id_idx", using: :btree
  add_index "alcon_plan_drug_settings", ["updated_by"], name: "alcon_plan_drug_settings_updated_by_idx", using: :btree

  create_table "alcon_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alcon_plan_settings", force: :cascade do |t|
    t.integer  "healthplan_id",                    null: false
    t.integer  "state_id",                         null: false
    t.boolean  "exclude"
    t.datetime "created_at",     default: "now()", null: false
    t.integer  "create_user_id"
    t.datetime "updated_at"
    t.integer  "update_user_id"
  end

  add_index "alcon_plan_settings", ["create_user_id"], name: "alcon_plan_settings_create_user_id", using: :btree
  add_index "alcon_plan_settings", ["healthplan_id"], name: "alcon_plan_settings_healthplan_id", using: :btree
  add_index "alcon_plan_settings", ["state_id"], name: "alcon_plan_settings_state_id", using: :btree
  add_index "alcon_plan_settings", ["update_user_id"], name: "alcon_plan_settings_update_user_id", using: :btree

  create_table "alcon_plan_tier_label", id: false, force: :cascade do |t|
    t.integer  "healthplan_id_fk",                   null: false
    t.integer  "tier_id_fk",                         null: false
    t.integer  "tier_label_id_fk",                   null: false
    t.datetime "create_timestamp", default: "now()"
    t.datetime "modify_timestamp", default: "now()"
  end

  add_index "alcon_plan_tier_label", ["healthplan_id_fk"], name: "alcon_tier_label_tier_healthplan_id", using: :btree
  add_index "alcon_plan_tier_label", ["tier_id_fk"], name: "alcon_tier_label_tier_tier_id", using: :btree
  add_index "alcon_plan_tier_label", ["tier_label_id_fk"], name: "alcon_tier_label_tier_tier_label_id", using: :btree

  create_table "alcon_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "alcon_publish_plan_bold", primary_key: "healthplanid_fk", force: :cascade do |t|
    t.boolean  "publish_bold", default: false
    t.integer  "creatorid_fk"
    t.datetime "create_stamp", default: "now()"
  end

  create_table "alcon_publisher_formularies", force: :cascade do |t|
    t.string   "name",                        limit: 255
    t.integer  "publisher_template_id"
    t.integer  "created_by_id"
    t.string   "current_step",                limit: 255
    t.integer  "version"
    t.boolean  "is_active",                               default: true
    t.boolean  "is_published",                            default: false
    t.string   "competitor_drug_ids",         limit: 255, default: ""
    t.string   "health_plan_types",           limit: 255, default: ""
    t.string   "commercial_health_plan_ids",  limit: 255, default: ""
    t.string   "medicare_health_plan_ids",    limit: 255, default: ""
    t.string   "medicaid_health_plan_ids",    limit: 255, default: ""
    t.string   "highlighted_health_plan_ids", limit: 255, default: ""
    t.string   "bolded_health_plan_ids",      limit: 255, default: ""
    t.integer  "state_id"
    t.integer  "msa_id"
    t.integer  "county_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotlight_drug_ids",          limit: 255, default: ""
    t.boolean  "display_copay",                           default: false
    t.integer  "legacy_alconformulary_id"
    t.string   "table_version",               limit: 255
  end

  create_table "alcon_publisher_templates", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "klass_name",                limit: 255
    t.string   "spotlight_drug_ids",        limit: 255, default: ""
    t.string   "competitor_drug_ids",       limit: 255, default: ""
    t.integer  "health_plan_count_min"
    t.integer  "health_plan_count_max"
    t.integer  "competitor_drug_count_min"
    t.integer  "competitor_drug_count_max"
    t.string   "allowed_role_ids",          limit: 255, default: ""
    t.boolean  "is_active",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cf",                                    default: false
    t.integer  "drug_class_id"
  end

  create_table "alcon_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "requires_approval",             default: 0
    t.integer  "admin",                         default: 0
    t.integer  "publisher",                     default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "accounts",                      default: 0
    t.integer  "active",                        default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alcon_tier_label", force: :cascade do |t|
    t.integer  "tier_id_fk",                                         null: false
    t.string   "label",                limit: 255
    t.boolean  "display_qual",                     default: true
    t.string   "qualifier_limit_list", limit: 255
    t.string   "medicaid_preference",  limit: 50
    t.datetime "create_timestamp",                 default: "now()"
    t.datetime "modify_timestamp",                 default: "now()"
    t.integer  "active",                           default: 1,       null: false
  end

  add_index "alcon_tier_label", ["tier_id_fk"], name: "alcon_tier_label_tier_id", using: :btree

  create_table "alcon_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "alcon_users", force: :cascade do |t|
    t.string   "login",          limit: 255
    t.string   "email",          limit: 255
    t.string   "password",       limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.string   "first_name",     limit: 200
    t.string   "last_name",      limit: 200
    t.integer  "role_id"
    t.integer  "active",                     default: 0
    t.integer  "approved",                   default: 0
    t.string   "activation_key", limit: 50
  end

  create_table "alcondrugplanform", primary_key: "entityid", force: :cascade do |t|
    t.integer "formularyfid",               null: false
    t.integer "planid",                     null: false
    t.integer "drugid",                     null: false
    t.integer "coveragestatus",             null: false
    t.boolean "priorauth",                  null: false
    t.boolean "quantlimit",                 null: false
    t.boolean "stepther",                   null: false
    t.boolean "restrother",                 null: false
    t.integer "resaoncodefid",  default: 0, null: false
    t.integer "resetflag",      default: 0, null: false
    t.integer "paforall",       default: 0, null: false
  end

  add_index "alcondrugplanform", ["drugid"], name: "alcondrugplanform_drugid_idx", using: :btree
  add_index "alcondrugplanform", ["formularyfid"], name: "alcondrugplanform_formularyid_idx", using: :btree
  add_index "alcondrugplanform", ["planid"], name: "alcondrugplanform_planid_idx", using: :btree

  create_table "alconformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.integer  "statefid"
    t.integer  "msafid"
    t.integer  "drugclassfid",                                  null: false
    t.string   "planlist",                                      null: false
    t.string   "druglist",                                      null: false
    t.string   "tableversion",          limit: 100,             null: false
    t.integer  "versionnumber",                     default: 0, null: false
    t.integer  "ispublished",                       default: 0, null: false
    t.integer  "isexported",                        default: 0, null: false
    t.integer  "isactive",                          default: 1, null: false
    t.datetime "createtimestamp",                               null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "modifytimestamp",                               null: false
    t.integer  "mostrecent",                        default: 0, null: false
    t.string   "planorderedlist",       limit: 255
    t.string   "planboldedlist",        limit: 255
    t.string   "commercialplanordered", limit: 255
    t.string   "medicareplanordered",   limit: 255
    t.string   "medicaidplanordered",   limit: 255
    t.string   "description",           limit: 100
    t.string   "doctorname",            limit: 100
    t.integer  "tabletype",                         default: 1, null: false
    t.string   "template",              limit: 50
    t.string   "repname",               limit: 100
    t.integer  "copay_option",                      default: 0, null: false
  end

  add_index "alconformulary", ["drugclassfid"], name: "alconformulary_drugclassid_idx", using: :btree
  add_index "alconformulary", ["msafid"], name: "alconformulary_msaid_idx", using: :btree
  add_index "alconformulary", ["statefid"], name: "alconformulary_stateid_idx", using: :btree
  add_index "alconformulary", ["userfid"], name: "alconformulary_userid_idx", using: :btree

  create_table "alconmsa", force: :cascade do |t|
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 100
    t.datetime "modified",                default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "alconmsastate", force: :cascade do |t|
    t.integer  "msafid",                     null: false
    t.integer  "statefid",                   null: false
    t.datetime "modified", default: "now()", null: false
    t.integer  "active",   default: 1,       null: false
  end

  add_index "alconmsastate", ["msafid"], name: "alconmsastate_msaid_idx", using: :btree

  create_table "alconrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,                  null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0,     null: false
    t.integer  "requiresapproval",             default: 0,     null: false
    t.integer  "createtable",                  default: 0,     null: false
    t.datetime "createtimestamp",                              null: false
    t.datetime "modifytimestamp",                              null: false
    t.boolean  "analytics",                    default: false
  end

  create_table "alconuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "alconuser", ["email"], name: "alconuser_email_key", unique: true, using: :btree

  create_table "alconusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "alert", force: :cascade do |t|
    t.integer  "healthplanfid"
    t.integer  "drugfid"
    t.integer  "formularyentryfid"
    t.integer  "orderindex",                                       null: false
    t.integer  "tierfid",                          default: 8
    t.boolean  "priorauth",                        default: false, null: false
    t.boolean  "quantlimit",                       default: false, null: false
    t.boolean  "stepther",                         default: false, null: false
    t.datetime "createtimestamp",                                  null: false
    t.boolean  "resetflag",                        default: false
    t.integer  "legacyfid",                                        null: false
    t.boolean  "restrother",                       default: false, null: false
    t.integer  "reasoncodefid",                    default: 0,     null: false
    t.boolean  "preferred"
    t.string   "restriction_comments", limit: 256
  end

  add_index "alert", ["createtimestamp"], name: "idx_alert_createtimestamp", using: :btree
  add_index "alert", ["drugfid"], name: "idx_alert_drugfid", using: :btree
  add_index "alert", ["formularyentryfid"], name: "idx_alert_formularyentryfid", using: :btree
  add_index "alert", ["healthplanfid"], name: "idx_alert_healthplanfid", using: :btree
  add_index "alert", ["tierfid"], name: "idx_alert_tierfid", using: :btree

  create_table "allergan_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2009-04-03 13:10:54'
    t.datetime "updated_at",                              default: '2009-04-03 13:10:54'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "allergan_formularies", ["drug_class_id"], name: "allergan_formularies_drug_class_id_idx", using: :btree
  add_index "allergan_formularies", ["site_user_id"], name: "allergan_formularies_site_user_id_idx", using: :btree
  add_index "allergan_formularies", ["state_id"], name: "allergan_formularies_state_id_idx", using: :btree
  add_index "allergan_formularies", ["template"], name: "allergan_formularies_template_idx", using: :btree

  create_table "allergan_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "site_user_id"
    t.datetime "created_at",    default: '2009-04-03 13:10:54'
    t.datetime "updated_at",    default: '2009-04-03 13:10:54'
    t.boolean  "exclude",       default: false
    t.boolean  "bold",          default: false
    t.boolean  "highlight",     default: false
  end

  add_index "allergan_plan_drug_settings", ["drug_id"], name: "allergan_plan_drug_settings_drug_id_idx", using: :btree
  add_index "allergan_plan_drug_settings", ["healthplan_id"], name: "allergan_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "allergan_plan_drug_settings", ["site_user_id"], name: "allergan_plan_drug_settings_site_user_id_idx", using: :btree
  add_index "allergan_plan_drug_settings", ["state_id"], name: "allergan_plan_drug_settings_state_id_idx", using: :btree

  create_table "allergan_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at",         default: '2009-04-03 13:10:54'
    t.datetime "updated_at",         default: '2009-04-03 13:10:54'
    t.integer  "updated_by_user_id"
  end

  create_table "allergan_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.datetime "created_at",                    default: '2009-04-03 13:10:54'
    t.datetime "updated_at",                    default: '2009-04-03 13:10:54'
  end

  create_table "allergan_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: '2009-04-03 13:10:54'
    t.datetime "updated_at",                      default: '2009-04-03 13:10:54'
  end

  create_table "allergan_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2009-04-03 13:10:54'
    t.datetime "last_accessed_timestamp",             default: '2009-04-03 13:10:54'
  end

  create_table "allergan_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "analytics_bookmarks", force: :cascade do |t|
    t.integer  "sitefid",                                                 null: false
    t.integer  "userfid",                                                 null: false
    t.string   "bookmark",                  limit: 50,                    null: false
    t.string   "report",                    limit: 50,                    null: false
    t.string   "drugclassid",               limit: 2000
    t.string   "geography",                 limit: 1
    t.string   "regions",                   limit: 300
    t.string   "msas",                      limit: 2000
    t.string   "counties",                  limit: 750
    t.string   "state",                     limit: 3
    t.string   "msa",                       limit: 4
    t.string   "county",                    limit: 4
    t.string   "displaylives",              limit: 5
    t.string   "plantypes",                 limit: 50
    t.string   "drugs",                     limit: 500
    t.string   "restriction",               limit: 1
    t.string   "criterium",                 limit: 50
    t.string   "indexdrug",                 limit: 5
    t.string   "comparisondrug",            limit: 5
    t.string   "indexplantypes",            limit: 50
    t.string   "comparisonplantypes",       limit: 50
    t.string   "plantype",                  limit: 2
    t.string   "drug",                      limit: 5
    t.string   "displayshare",              limit: 5
    t.string   "period",                    limit: 10
    t.string   "drugid",                    limit: 5
    t.string   "dates",                     limit: 50
    t.string   "from_year",                 limit: 4
    t.string   "from_month",                limit: 2
    t.string   "to_year",                   limit: 4
    t.string   "to_month",                  limit: 2
    t.string   "tiervalue",                 limit: 20
    t.string   "pavalue",                   limit: 3
    t.string   "qlvalue",                   limit: 3
    t.string   "stvalue",                   limit: 3
    t.string   "orvalue",                   limit: 3
    t.string   "druga",                     limit: 5
    t.string   "tiera",                     limit: 20
    t.string   "paa",                       limit: 3
    t.string   "qla",                       limit: 3
    t.string   "sta",                       limit: 3
    t.string   "ora",                       limit: 3
    t.string   "reasoncodea",               limit: 100
    t.string   "drugb",                     limit: 5
    t.string   "tierb",                     limit: 20
    t.string   "pab",                       limit: 3
    t.string   "qlb",                       limit: 3
    t.string   "stb",                       limit: 3
    t.string   "orb",                       limit: 3
    t.string   "reasoncodeb",               limit: 100
    t.string   "operator",                  limit: 3
    t.string   "lives",                     limit: 15
    t.string   "planfinderdate",            limit: 20
    t.string   "zipcode",                   limit: 5
    t.string   "marketbasket",              limit: 2
    t.string   "marketbasketvalue",         limit: 2
    t.string   "reportlistallowed",         limit: 5
    t.string   "copaychannel",              limit: 3
    t.string   "planid",                    limit: 5
    t.string   "structureid",               limit: 6
    t.string   "imscode",                   limit: 10
    t.string   "imsname",                   limit: 100
    t.string   "imsid",                     limit: 5
    t.string   "provider",                  limit: 5
    t.string   "displayunmappeddata",       limit: 5
    t.string   "paging",                    limit: 5
    t.string   "wkplanname",                limit: 100
    t.string   "wkplanid",                  limit: 8
    t.string   "wkplangid",                 limit: 8
    t.string   "rxcounttype",               limit: 5
    t.string   "rxdatasource",              limit: 3
    t.string   "rxdatadsn",                 limit: 10
    t.string   "sitename",                  limit: 100
    t.datetime "created"
    t.string   "tierr",                     limit: 20
    t.string   "tieru",                     limit: 20
    t.string   "qualr",                     limit: 10
    t.string   "qualu",                     limit: 10
    t.string   "ustate",                    limit: 3
    t.string   "level",                     limit: 10
    t.string   "plans",                     limit: 1000
    t.string   "copaymin",                  limit: 3
    t.string   "copaymax",                  limit: 3
    t.string   "coinsmin",                  limit: 3
    t.string   "coinsmax",                  limit: 3
    t.string   "searchranges",              limit: 20
    t.string   "acct",                      limit: 5
    t.string   "macct",                     limit: 5
    t.string   "t3preferred",               limit: 1
    t.string   "tcpid",                     limit: 7
    t.string   "pbm",                       limit: 5
    t.string   "livesstate",                limit: 3
    t.string   "group_by",                  limit: 8
    t.string   "source",                    limit: 7
    t.string   "metric",                    limit: 2
    t.string   "include_na",                limit: 5
    t.boolean  "report_is_shared",                       default: false
    t.string   "supply",                    limit: 5
    t.string   "eligible",                  limit: 10
    t.string   "preferred",                 limit: 20
    t.string   "zerocopayu",                limit: 5,    default: "true"
    t.string   "t3u",                       limit: 5,    default: "true"
    t.string   "medicaidr",                 limit: 5,    default: "true"
    t.string   "qualifier",                 limit: 1
    t.string   "pref_brands",               limit: 12
    t.string   "is_unmapped_plan_details",  limit: 5
    t.string   "medicaid_preferred_status", limit: 5
  end

  create_table "analytics_bookmarks_hidden", id: false, force: :cascade do |t|
    t.integer "analytics_bookmark_id", null: false
    t.integer "sitefid",               null: false
    t.integer "userfid",               null: false
  end

  create_table "analytics_key_accounts", id: :bigserial, force: :cascade do |t|
    t.integer  "sitefid",                                           null: false
    t.string   "name",                limit: 100,                   null: false
    t.string   "planlist",                                          null: false
    t.integer  "shared",                          default: 0,       null: false
    t.datetime "created",                         default: "now()", null: false
    t.integer  "createduserfid",                                    null: false
    t.datetime "lastmodified",                    default: "now()", null: false
    t.integer  "lastmodifieduserfid",                               null: false
    t.integer  "active",                          default: 1,       null: false
  end

  create_table "analytics_key_accounts_share_permissions", id: false, force: :cascade do |t|
    t.integer "id",              null: false
    t.string  "name", limit: 50, null: false
  end

  create_table "analytics_master_accounts", force: :cascade do |t|
    t.integer  "sitefid",                                           null: false
    t.string   "name",                limit: 100,                   null: false
    t.integer  "shared",                          default: 0,       null: false
    t.datetime "created",                         default: "now()", null: false
    t.integer  "createduserfid",                                    null: false
    t.datetime "lastmodified",                    default: "now()", null: false
    t.integer  "lastmodifieduserfid",                               null: false
    t.integer  "active",                          default: 1,       null: false
  end

  create_table "analytics_master_key_accounts", force: :cascade do |t|
    t.integer "master_account_id", null: false
    t.integer "key_account_id",    null: false
  end

  create_table "analytics_reports", force: :cascade do |t|
    t.string  "name",           limit: 50,              null: false
    t.string  "title",          limit: 100,             null: false
    t.text    "description"
    t.integer "reporttype",                 default: 1, null: false
    t.integer "geography",                  default: 1, null: false
    t.integer "displayorder",               default: 1, null: false
    t.integer "isactive",                   default: 1, null: false
    t.integer "custom_account",             default: 0, null: false
  end

  create_table "analytics_reports_rx_metrics", id: false, force: :cascade do |t|
    t.integer "site_id"
    t.integer "report_id"
    t.integer "metric_id"
    t.boolean "is_active"
    t.integer "drug_class_id"
  end

  create_table "analytics_role_restricted_drug_classes", force: :cascade do |t|
    t.integer  "site_id",       null: false
    t.integer  "role_id",       null: false
    t.integer  "drug_class_id", null: false
    t.datetime "created_on"
    t.integer  "created_by"
  end

  create_table "analytics_rx_metrics", force: :cascade do |t|
    t.string  "name",          limit: 50
    t.integer "display_order"
  end

  create_table "analytics_utilization", force: :cascade do |t|
    t.integer  "sitefid",                        null: false
    t.integer  "userfid",                        null: false
    t.integer  "reportfid",                      null: false
    t.integer  "drugclassfid",                   null: false
    t.integer  "geography",                      null: false
    t.integer  "displaylives",                   null: false
    t.datetime "created",      default: "now()", null: false
    t.integer  "accountfid"
  end

  add_index "analytics_utilization", ["reportfid"], name: "analytics_utilization_reportfid", using: :btree
  add_index "analytics_utilization", ["sitefid"], name: "analytics_utilization_sitefid", using: :btree
  add_index "analytics_utilization", ["userfid"], name: "analytics_utilization_userfid", using: :btree

  create_table "attachment_files", force: :cascade do |t|
    t.integer  "size"
    t.string   "content_type", limit: 255
    t.string   "filename",     limit: 255
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail",    limit: 255
    t.integer  "db_file_id"
    t.datetime "created_at"
  end

  create_table "axcanformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                          null: false
    t.integer  "statefid"
    t.integer  "msafid"
    t.integer  "drugclassfid",                                     null: false
    t.string   "planlist",                                         null: false
    t.string   "druglist",                                         null: false
    t.string   "tableversion",             limit: 100,             null: false
    t.integer  "versionnumber",                        default: 0, null: false
    t.integer  "ispublished",                          default: 0, null: false
    t.integer  "isexported",                           default: 0, null: false
    t.integer  "isactive",                             default: 1, null: false
    t.datetime "createtimestamp",                                  null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "modifytimestamp",                                  null: false
    t.integer  "mostrecent",                           default: 0, null: false
    t.string   "planorderedlist",          limit: 500
    t.string   "planboldedlist",           limit: 500
    t.string   "description",              limit: 100
    t.string   "doctorname",               limit: 100
    t.integer  "tabletype",                            default: 1, null: false
    t.string   "template",                 limit: 50
    t.string   "repname",                  limit: 100
    t.string   "plan_type_category_order", limit: 50
    t.integer  "header_option"
    t.string   "mark_new_list",            limit: 500
    t.string   "geo_area_name",            limit: 255
  end

  add_index "axcanformulary", ["drugclassfid"], name: "axcanformulary_drugclassid_idx", using: :btree
  add_index "axcanformulary", ["msafid"], name: "axcanformulary_msaid_idx", using: :btree
  add_index "axcanformulary", ["statefid"], name: "axcanformulary_stateid_idx", using: :btree
  add_index "axcanformulary", ["userfid"], name: "axcanformulary_userid_idx", using: :btree

  create_table "axcanrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,                  null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0,     null: false
    t.integer  "requiresapproval",             default: 0,     null: false
    t.integer  "createtable",                  default: 0,     null: false
    t.datetime "createtimestamp",                              null: false
    t.datetime "modifytimestamp",                              null: false
    t.boolean  "analytics",                    default: false, null: false
  end

  create_table "axcanuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "axcanuser", ["email"], name: "axcanuser_email_key", unique: true, using: :btree

  create_table "axcanusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "az_admin_msa_name_logs", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "metro_stat_area_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_msa_name_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "metro_stat_area_id"
  end

  create_table "az_admin_ordering_logs", force: :cascade do |t|
    t.integer  "az_formulary_order_default_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_ordering_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_plan_exclusion_tsi_logs", force: :cascade do |t|
    t.integer  "drug_id"
    t.integer  "provider_id"
    t.integer  "health_plan_type_id"
    t.integer  "health_plan_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_plan_exclusion_tsi_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "provider_id"
    t.integer  "health_plan_id"
    t.integer  "drug_id"
  end

  create_table "az_admin_plan_name_logs", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "health_plan_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_plan_name_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "provider_id"
    t.integer  "health_plan_id"
  end

  create_table "az_admin_plan_option_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_plan_tier_label_logs", force: :cascade do |t|
    t.integer  "tier_id"
    t.integer  "plan_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_plan_tier_label_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_provider_rollup_footer_logs", force: :cascade do |t|
    t.integer  "provider_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_provider_rollup_footer_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "provider_id"
  end

  create_table "az_admin_tier_label_logs", force: :cascade do |t|
    t.integer  "tier_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_tier_label_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_top_account_list_logs", force: :cascade do |t|
    t.integer  "az_top_account_id"
    t.integer  "provider_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_top_account_list_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_top_account_logs", force: :cascade do |t|
    t.integer  "az_top_account_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_admin_top_account_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_formularies", force: :cascade do |t|
    t.integer  "active",                                 default: 1
    t.integer  "published",                              default: 0
    t.integer  "user_id"
    t.datetime "created_at",                             default: "now()"
    t.datetime "updated_at",                             default: "now()"
    t.datetime "published_at"
    t.string   "title",                      limit: 100
    t.string   "version",                    limit: 100
    t.integer  "version_number",                         default: 0
    t.string   "template",                   limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.integer  "msa_id"
    t.integer  "county_id"
    t.string   "spotlight_drugs",            limit: 255
    t.string   "competitor_drugs",           limit: 255
    t.string   "plan_type_order",            limit: 255
    t.string   "commercial_plans_order",     limit: 255
    t.string   "medicare_plans_order",       limit: 255
    t.string   "medicaid_plans_order",       limit: 255
    t.string   "plans_new",                  limit: 255
    t.string   "plans_bold",                 limit: 255
    t.string   "physician_name",             limit: 255
    t.string   "rep_name",                   limit: 255
    t.integer  "formulary_id_pg1"
    t.integer  "formulary_id_pg2"
    t.boolean  "display_copay",                          default: false
    t.boolean  "display_covered_lives",                  default: false
    t.string   "employer_group_plans_order", limit: 255, default: ""
    t.string   "pbm_plans_order",            limit: 255, default: ""
    t.string   "selected_health_plan_types", limit: 255
    t.integer  "custom_header_option",                   default: 1
    t.string   "spotlight_message",          limit: 255, default: "0"
    t.string   "spotlight_plan",             limit: 255, default: "0"
    t.string   "displayed_audience",         limit: 255, default: ""
  end

  add_index "az_formularies", ["county_id"], name: "az_formularies_county_id_idx", using: :btree
  add_index "az_formularies", ["drug_class_id"], name: "az_formularies_drug_class_id_idx", using: :btree
  add_index "az_formularies", ["msa_id"], name: "az_formularies_msa_id_idx", using: :btree
  add_index "az_formularies", ["state_id"], name: "az_formularies_state_id_idx", using: :btree
  add_index "az_formularies", ["template"], name: "az_formularies_template_idx", using: :btree
  add_index "az_formularies", ["user_id"], name: "az_formularies_site_user_id_idx", using: :btree

  create_table "az_formulary_batch_formularies", force: :cascade do |t|
    t.datetime "created_at",                           default: '2009-03-02 16:23:06'
    t.datetime "updated_at",                           default: '2009-03-02 16:23:06'
    t.integer  "az_formulary_batch_id"
    t.integer  "az_formulary_id"
    t.integer  "az_formulary_status_code"
    t.string   "status_details",           limit: 255
    t.integer  "state_id"
    t.integer  "county_id"
    t.integer  "msa_id"
  end

  create_table "az_formulary_batch_job_files", force: :cascade do |t|
    t.integer  "az_formulary_batch_job_id"
    t.integer  "state_id"
    t.datetime "created_at",                            default: "now()"
    t.datetime "updated_at",                            default: "now()"
    t.string   "file_uri",                  limit: 255
  end

  create_table "az_formulary_batch_jobs", force: :cascade do |t|
    t.integer  "az_formulary_batch_id"
    t.integer  "user_id"
    t.datetime "created_at",            default: "now()"
    t.datetime "updated_at",            default: "now()"
    t.datetime "scheduled_for"
    t.datetime "completed_at"
    t.integer  "batch_job_status_code"
  end

  create_table "az_formulary_batches", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                                   default: "now()"
    t.datetime "updated_at",                                   default: "now()"
    t.integer  "ff_formulary_batch_status_code",               default: 1
    t.integer  "ff_formulary_batch_template_id"
    t.string   "batch_name",                     limit: 100
    t.string   "spotlight_drug_list",            limit: 255
    t.string   "competitor_drug_list",           limit: 255
    t.string   "state_list",                     limit: 255
    t.string   "msa_list",                       limit: 1600
    t.string   "county_list",                    limit: 15000
    t.string   "commercial_required_list",       limit: 15000
    t.string   "medicare_required_list",         limit: 15000
    t.string   "medicaid_required_list",         limit: 1500
    t.integer  "commercial_count"
    t.integer  "medicare_count"
    t.integer  "medicaid_count"
    t.string   "tier_criteria_list",             limit: 255
    t.integer  "pa_qualifier_criteria"
    t.integer  "ql_qualifier_criteria"
    t.integer  "st_qualifier_criteria"
    t.integer  "or_qualifier_criteria"
    t.string   "sort_criteria",                  limit: 255
    t.boolean  "tier_prefered",                                default: false
    t.integer  "custom_header_option",                         default: 1
    t.string   "displayed_audience",             limit: 255,   default: ""
  end

  create_table "az_formulary_order_addresses", force: :cascade do |t|
    t.integer  "az_user_id"
    t.integer  "az_formulary_order_id"
    t.string   "first_name",            limit: 255
    t.string   "last_name",             limit: 255
    t.string   "address_1",             limit: 255
    t.string   "address_2",             limit: 255
    t.string   "city",                  limit: 255
    t.integer  "state_id"
    t.string   "zip_code",              limit: 255
    t.string   "telephone_1",           limit: 255
    t.string   "telephone_2",           limit: 255
    t.string   "telephone_3",           limit: 255
    t.string   "telephone_4",           limit: 255
    t.string   "email",                 limit: 255
    t.boolean  "store",                             default: false
    t.datetime "created_at"
    t.integer  "lock_version",                      default: 0
  end

  add_index "az_formulary_order_addresses", ["az_formulary_order_id"], name: "az_formulary_order_addresses_az_formulary_order_idx", using: :btree
  add_index "az_formulary_order_addresses", ["az_user_id"], name: "az_formulary_order_addresses_az_user_idx", using: :btree

  create_table "az_formulary_order_defaults", force: :cascade do |t|
    t.integer  "az_role_id"
    t.integer  "quantity"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.integer  "lock_version",             default: 0
    t.integer  "ff_publisher_template_id"
  end

  create_table "az_formulary_order_users", force: :cascade do |t|
    t.integer  "az_user_id"
    t.integer  "drug_id"
    t.integer  "quantity"
    t.datetime "modified_at"
    t.integer  "modified_by"
    t.integer  "lock_version", default: 0
  end

  create_table "az_formulary_orders", force: :cascade do |t|
    t.integer  "az_user_id"
    t.integer  "az_formulary_id"
    t.integer  "quantity"
    t.boolean  "special_dl",                  default: false
    t.datetime "created_at"
    t.integer  "lock_version",                default: 0
    t.string   "pdf_file",        limit: 255,                 null: false
    t.boolean  "order_sent",                  default: false, null: false
    t.datetime "updated_at"
    t.boolean  "order_ftp",                   default: false, null: false
  end

  add_index "az_formulary_orders", ["az_formulary_id"], name: "az_formulary_orders_az_formulary_idx", using: :btree
  add_index "az_formulary_orders", ["az_user_id"], name: "az_formulary_orders_az_user_idx", using: :btree

  create_table "az_formulary_required_plans", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.boolean  "required",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_formulary_statuses", force: :cascade do |t|
    t.integer  "code",                                      null: false
    t.integer  "active",                  default: 1,       null: false
    t.string   "label",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              default: "now()"
  end

  add_index "az_formulary_statuses", ["code"], name: "az_formulary_statuses_code_key", unique: true, using: :btree

  create_table "az_formulary_table_options", force: :cascade do |t|
    t.integer  "formulary_table_id"
    t.integer  "accompanying_formulary_table_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_ip_access", force: :cascade do |t|
    t.integer  "active",                  default: 1
    t.datetime "created_at",              default: "now()"
    t.datetime "updated_at"
    t.string   "ip",          limit: 255
    t.string   "description", limit: 255
    t.integer  "octets"
  end

  create_table "az_ip_address_event_logs", force: :cascade do |t|
    t.string   "event",                limit: 255
    t.integer  "site_user_id"
    t.string   "previous_ip",          limit: 255
    t.string   "previous_description", limit: 255
    t.string   "new_ip",               limit: 255
    t.string   "new_description",      limit: 255
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_msa_names", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",             default: '2008-06-06 10:11:31'
    t.datetime "updated_at",             default: '2008-06-06 10:11:31'
    t.integer  "msa_id"
    t.string   "name",       limit: 100
  end

  add_index "az_msa_names", ["msa_id"], name: "az_msa_names_msa_idx", using: :btree

  create_table "az_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "az_plan_drug_options", ["created_by"], name: "az_plan_drug_options_created_by_idx", using: :btree
  add_index "az_plan_drug_options", ["updated_by"], name: "az_plan_drug_options_updated_by_idx", using: :btree

  create_table "az_plan_drug_setting_logs", force: :cascade do |t|
    t.integer  "drug_id"
    t.integer  "provider_id"
    t.integer  "health_plan_type_id"
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "az_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "az_plan_drug_settings", ["created_by"], name: "az_plan_drug_settings_created_by_idx", using: :btree
  add_index "az_plan_drug_settings", ["drug_id"], name: "az_plan_drug_settings_drug_id_idx", using: :btree
  add_index "az_plan_drug_settings", ["healthplan_id"], name: "az_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "az_plan_drug_settings", ["plan_drug_option_id"], name: "az_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "az_plan_drug_settings", ["state_id"], name: "az_plan_drug_settings_state_id_idx", using: :btree
  add_index "az_plan_drug_settings", ["updated_by"], name: "az_plan_drug_settings_updated_by_idx", using: :btree

  create_table "az_plan_exclusions", force: :cascade do |t|
    t.boolean  "active",        default: true
    t.integer  "provider_id"
    t.integer  "healthplan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "az_user_id"
    t.integer  "drugclass_id",                 null: false
    t.boolean  "exclude_table", default: true, null: false
    t.boolean  "exclude_batch", default: true, null: false
    t.integer  "drug_id"
  end

  add_index "az_plan_exclusions", ["drugclass_id"], name: "az_plan_exclusions_drugclass_idx", using: :btree
  add_index "az_plan_exclusions", ["healthplan_id"], name: "az_plan_exclusions_healthplan_idx", using: :btree
  add_index "az_plan_exclusions", ["provider_id"], name: "az_plan_exclusions_provider_idx", using: :btree

  create_table "az_plan_formats", force: :cascade do |t|
    t.boolean  "active",        default: true
    t.integer  "drugclass_id"
    t.integer  "provider_id"
    t.integer  "healthplan_id"
    t.integer  "state_id"
    t.boolean  "include_table", default: true
    t.boolean  "bold",          default: false
    t.boolean  "highlight",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "az_user_id"
  end

  add_index "az_plan_formats", ["drugclass_id"], name: "az_plan_formats_drugclass_idx", using: :btree
  add_index "az_plan_formats", ["healthplan_id"], name: "az_plan_formats_healthplan_idx", using: :btree
  add_index "az_plan_formats", ["provider_id"], name: "az_plan_formats_provider_idx", using: :btree
  add_index "az_plan_formats", ["state_id"], name: "az_plan_formats_state_idx", using: :btree

  create_table "az_plan_tier_label", id: false, force: :cascade do |t|
    t.integer  "healthplan_id_fk",                                                            null: false
    t.integer  "tier_id_fk",                                                                  null: false
    t.integer  "tier_label_id_fk",                                                            null: false
    t.datetime "create_timestamp", default: "now()"
    t.datetime "modify_timestamp", default: "now()"
    t.integer  "id",               default: "nextval('az_plan_tier_label_id_seq'::regclass)"
  end

  add_index "az_plan_tier_label", ["healthplan_id_fk"], name: "az_tier_label_tier_healthplan_id", using: :btree
  add_index "az_plan_tier_label", ["tier_id_fk"], name: "az_tier_label_tier_tier_id", using: :btree
  add_index "az_plan_tier_label", ["tier_label_id_fk"], name: "az_tier_label_tier_tier_label_id", using: :btree

  create_table "az_provider_rollup_footers", force: :cascade do |t|
    t.boolean  "active",      default: true
    t.integer  "provider_id"
    t.boolean  "show_footer", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "az_user_id"
  end

  add_index "az_provider_rollup_footers", ["provider_id"], name: "az_provider_rollup_footers_provider_idx", using: :btree

  create_table "az_region_image", id: false, force: :cascade do |t|
    t.integer "region_id"
    t.string  "region_type", limit: 10, null: false
    t.string  "file_name",   limit: 50, null: false
  end

  create_table "az_roles", force: :cascade do |t|
    t.string   "role",                          limit: 200
    t.string   "description",                   limit: 200
    t.integer  "adminonly",                                 default: 0
    t.integer  "requiresapproval",                          default: 0
    t.integer  "createtable",                               default: 0
    t.integer  "reporting",                                 default: 0
    t.integer  "analytics",                                 default: 0
    t.integer  "alerts",                                    default: 0
    t.integer  "request_account",                           default: 0
    t.integer  "plan_management",                           default: 0
    t.integer  "active",                                    default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "view_formulary_data",                       default: 0
    t.integer  "restrictions",                              default: 0
    t.integer  "accounts_permission",                       default: 0,     null: false
    t.string   "drug_permission_list",          limit: 255
    t.string   "valid_email_ext_list",          limit: 255
    t.integer  "admin_plan_name",                           default: 0
    t.integer  "admin_plan_tier",                           default: 0
    t.integer  "admin_batch_exclusion",                     default: 0
    t.integer  "admin_msa_name",                            default: 0
    t.integer  "admin_ordering_tool",                       default: 0
    t.integer  "admin_provider_rollup",                     default: 0
    t.integer  "admin_top_accounts",                        default: 0
    t.integer  "admin_seroquel_required_plans",             default: 0
    t.boolean  "is_super_user",                             default: false
    t.boolean  "role_restricted_search",                    default: false
  end

  create_table "az_tier_label", force: :cascade do |t|
    t.integer  "tier_id_fk",                                         null: false
    t.string   "label",                limit: 255
    t.boolean  "display_qual",                     default: true
    t.datetime "create_timestamp",                 default: "now()"
    t.datetime "modify_timestamp",                 default: "now()"
    t.string   "medicaid_preference",  limit: 50
    t.string   "qualifier_limit_list", limit: 255
  end

  add_index "az_tier_label", ["tier_id_fk"], name: "az_tier_label_tier_id", using: :btree

  create_table "az_top_account_providers", force: :cascade do |t|
    t.datetime "updated_at",        default: "now()"
    t.integer  "user_id"
    t.integer  "az_top_account_id"
    t.integer  "provider_id"
  end

  create_table "az_top_accounts", force: :cascade do |t|
    t.datetime "updated_at",                 default: "now()"
    t.integer  "user_id"
    t.string   "list_name",      limit: 100
    t.integer  "provider_limit"
  end

  create_table "az_users", force: :cascade do |t|
    t.string   "login",                     limit: 75
    t.string   "email",                     limit: 255
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "remember_token",            limit: 255
    t.datetime "remember_token_expires_at"
    t.string   "first_name",                limit: 200
    t.string   "last_name",                 limit: 200
    t.integer  "az_role_id"
    t.integer  "active",                                default: 0
    t.integer  "approved",                              default: 0
    t.integer  "alerts",                                default: 0
    t.string   "activationkey",             limit: 50
    t.string   "region_id",                 limit: 50
    t.string   "district_id",               limit: 50
    t.string   "territory_id",              limit: 50
    t.string   "team_id",                   limit: 50
    t.string   "unecrypted_password",       limit: 50
  end

  add_index "az_users", ["email"], name: "az_users_email_idx", using: :btree

  create_table "azbusinesscenter", primary_key: "entityid", force: :cascade do |t|
    t.string "businesscenter", limit: 50, null: false
  end

  create_table "azformulary_createtype", force: :cascade do |t|
    t.string  "name",                         limit: 50,                null: false
    t.boolean "export_nonmedicare_allstates",            default: true, null: false
  end

  create_table "azmsa", force: :cascade do |t|
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 100
    t.datetime "modified",                default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "azmsastate", force: :cascade do |t|
    t.integer  "azmsafid",                   null: false
    t.integer  "statefid",                   null: false
    t.datetime "modified", default: "now()", null: false
    t.integer  "active",   default: 1,       null: false
  end

  create_table "azstate", primary_key: "entityid", force: :cascade do |t|
    t.integer "businesscenterfid",             null: false
    t.string  "state",             limit: 100, null: false
    t.string  "ffabbreviation",    limit: 2,   null: false
  end

  create_table "azuseralert", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.integer  "legacyfid"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "archived_at"
  end

  create_table "azuserservice", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid",      null: false
    t.integer "drugclassfid"
  end

  create_table "azusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "bayer_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2010-09-09 17:40:27'
    t.datetime "updated_at",                              default: '2010-09-09 17:40:27'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "bayer_formularies", ["drug_class_id"], name: "bayer_formularies_drug_class_id_idx", using: :btree
  add_index "bayer_formularies", ["site_user_id"], name: "bayer_formularies_site_user_id_idx", using: :btree
  add_index "bayer_formularies", ["state_id"], name: "bayer_formularies_state_id_idx", using: :btree
  add_index "bayer_formularies", ["template"], name: "bayer_formularies_template_idx", using: :btree

  create_table "bayer_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "bayer_plan_drug_options", ["created_by"], name: "bayer_plan_drug_options_created_by_idx", using: :btree
  add_index "bayer_plan_drug_options", ["updated_by"], name: "bayer_plan_drug_options_updated_by_idx", using: :btree

  create_table "bayer_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "bayer_plan_drug_settings", ["created_by"], name: "bayer_plan_drug_settings_created_by_idx", using: :btree
  add_index "bayer_plan_drug_settings", ["drug_id"], name: "bayer_plan_drug_settings_drug_id_idx", using: :btree
  add_index "bayer_plan_drug_settings", ["healthplan_id"], name: "bayer_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "bayer_plan_drug_settings", ["plan_drug_option_id"], name: "bayer_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "bayer_plan_drug_settings", ["state_id"], name: "bayer_plan_drug_settings_state_id_idx", using: :btree
  add_index "bayer_plan_drug_settings", ["updated_by"], name: "bayer_plan_drug_settings_updated_by_idx", using: :btree

  create_table "bayer_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bayer_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bayer_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "bayer_roles", force: :cascade do |t|
    t.string   "role",                limit: 200
    t.string   "description",         limit: 200
    t.integer  "adminonly",                       default: 0
    t.integer  "requires_approval",               default: 0
    t.integer  "formulary_tables",                default: 0
    t.integer  "accounts",                        default: 0
    t.integer  "analytics",                       default: 0
    t.integer  "active",                          default: 1
    t.boolean  "is_super_user",                   default: false
    t.datetime "created_at",                      default: '2010-09-09 17:40:27'
    t.datetime "updated_at",                      default: '2010-09-09 17:40:27'
    t.integer  "restrictions",                    default: 0
    t.integer  "is_medical_benefits",             default: 0,                     null: false
  end

  create_table "bayer_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "bayer_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-09-09 17:40:27'
    t.datetime "last_accessed_timestamp",             default: '2010-09-09 17:40:27'
  end

  create_table "bayer_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "benefit_medicare_cost", force: :cascade do |t|
    t.string  "contract_id",       limit: 20
    t.string  "plan_id",           limit: 3
    t.integer "tier"
    t.integer "days_supply"
    t.integer "cost_type_pref"
    t.decimal "cost_amt_pref",                precision: 8, scale: 2
    t.integer "cost_type_nonpref"
    t.decimal "cost_amt_non_pref",            precision: 8, scale: 2
    t.integer "cost_type_mail"
    t.decimal "cost_amt_mail",                precision: 8, scale: 2
    t.string  "tier_specialty_yn", limit: 1
    t.string  "ded_applies_yn",    limit: 1
    t.integer "imported",          limit: 2,                          default: 0, null: false
    t.integer "cms_plan_id"
  end

  add_index "benefit_medicare_cost", ["contract_id", "plan_id"], name: "benefit_medicare_cost_contract_plan_idx", using: :btree
  add_index "benefit_medicare_cost", ["contract_id"], name: "benefit_medicare_cost_contract_idx", using: :btree
  add_index "benefit_medicare_cost", ["plan_id"], name: "benefit_medicare_cost_plan_idx", using: :btree

  create_table "benefit_medicare_plan", force: :cascade do |t|
    t.string  "contract_id",        limit: 20
    t.string  "plan_id",            limit: 3
    t.string  "segment_id",         limit: 3
    t.string  "contract_name",      limit: 50
    t.string  "plan_name",          limit: 100
    t.string  "formulary_id",       limit: 8
    t.decimal "premium"
    t.decimal "deductible",                     precision: 8, scale: 2
    t.string  "icl",                limit: 7
    t.string  "ma_region_code",     limit: 2
    t.string  "pdp_region_code",    limit: 2
    t.string  "state",              limit: 2
    t.string  "county_code",        limit: 5
    t.integer "snp"
    t.string  "plan_suppressed_yn", limit: 1
  end

  create_table "benefit_medicare_plan_data", force: :cascade do |t|
    t.string  "contract_id",     limit: 20
    t.string  "plan_id",         limit: 3
    t.string  "plan_name",       limit: 255
    t.decimal "premium"
    t.decimal "deductible",                  precision: 8, scale: 2
    t.string  "ma_region_code",  limit: 2
    t.string  "pdp_region_code", limit: 2
    t.string  "state",           limit: 2
    t.integer "snp"
    t.integer "statefid"
    t.integer "cms_plan_id"
    t.integer "imported",        limit: 2,                           default: 0, null: false
  end

  create_table "benefitstructure", force: :cascade do |t|
    t.integer  "healthplanfid",                                                                      null: false
    t.string   "benefitplanname",                 limit: 255,                                        null: false
    t.string   "benefitplanurl",                  limit: 500
    t.string   "medicarecontractid",              limit: 50
    t.decimal  "deductible",                                  precision: 8, scale: 2
    t.string   "coveragegap",                     limit: 500
    t.string   "catastrophiccoverage",            limit: 500
    t.string   "comments",                        limit: 500
    t.datetime "createtimestamp",                                                                    null: false
    t.datetime "modifytimestamp",                                                                    null: false
    t.integer  "createdby"
    t.integer  "modifiedby"
    t.integer  "active",                                                              default: 1,    null: false
    t.decimal  "premium"
    t.string   "source",                          limit: 3,                           default: "ff", null: false
    t.integer  "cms_plan_id"
    t.decimal  "specialty_copay_min",                         precision: 8, scale: 2
    t.decimal  "specialty_copay_max",                         precision: 8, scale: 2
    t.decimal  "specialty_coinsurance_min",                   precision: 8, scale: 2
    t.decimal  "specialty_coinsurance_max",                   precision: 8, scale: 2
    t.decimal  "medical_benefit_coinsurance_min",             precision: 8, scale: 2
    t.decimal  "medical_benefit_coinsurance_max",             precision: 8, scale: 2
    t.decimal  "medical_benefit_copay_min",                   precision: 8, scale: 2
    t.decimal  "medical_benefit_copay_max",                   precision: 8, scale: 2
  end

  add_index "benefitstructure", ["healthplanfid"], name: "benefitstructure_healthplanfid_idx", using: :btree
  add_index "benefitstructure", ["medicarecontractid"], name: "benefitstructure_medicarecontractid_idx", using: :btree

  create_table "benefitstructurecopay", force: :cascade do |t|
    t.integer  "benefitstructurefid",                          null: false
    t.integer  "pharmacytypefid",                              null: false
    t.integer  "copaytypefid",                                 null: false
    t.integer  "dayssupply"
    t.datetime "createtimestamp",                              null: false
    t.datetime "modifytimestamp",                              null: false
    t.integer  "active",                        default: 1,    null: false
    t.string   "source",              limit: 3, default: "ff", null: false
  end

  add_index "benefitstructurecopay", ["benefitstructurefid"], name: "benefitstructurecopay_benefitstructurefid_idx", using: :btree
  add_index "benefitstructurecopay", ["copaytypefid"], name: "benefitstructurecopay_copaytypefid_idx", using: :btree
  add_index "benefitstructurecopay", ["pharmacytypefid"], name: "benefitstructurecopay_pharmacytypefid_idx", using: :btree

  create_table "benefitstructurecopaytype", force: :cascade do |t|
    t.string   "copaytype",       limit: 100,             null: false
    t.datetime "createtimestamp",                         null: false
    t.datetime "modifytimestamp",                         null: false
    t.integer  "active",                      default: 1, null: false
  end

  create_table "benefitstructurecopayvalue", force: :cascade do |t|
    t.integer  "benefitstructurecopayfid",                                                  null: false
    t.integer  "tierfid",                                                                   null: false
    t.decimal  "value",                              precision: 8, scale: 2
    t.decimal  "max",                                precision: 8, scale: 2
    t.decimal  "percentage",                         precision: 8, scale: 2
    t.datetime "createtimestamp",                                                           null: false
    t.datetime "modifytimestamp",                                                           null: false
    t.integer  "active",                                                     default: 1,    null: false
    t.string   "source",                   limit: 3,                         default: "ff", null: false
    t.decimal  "percentage_max",                     precision: 8, scale: 2
  end

  add_index "benefitstructurecopayvalue", ["benefitstructurecopayfid"], name: "benefitstructurecopayvalue_benefitstructurecopayfid_idx", using: :btree

  create_table "benefitstructurepharmacycopaytypes", force: :cascade do |t|
    t.integer  "pharmacytypefid",             null: false
    t.integer  "copaytypefid",                null: false
    t.integer  "ordering",        default: 0, null: false
    t.datetime "createtimestamp",             null: false
    t.datetime "modifytimestamp",             null: false
    t.integer  "active",          default: 1, null: false
  end

  add_index "benefitstructurepharmacycopaytypes", ["copaytypefid"], name: "benefitstructurepharmacycopaytypes_copaytypefid_idx", using: :btree
  add_index "benefitstructurepharmacycopaytypes", ["pharmacytypefid"], name: "benefitstructurepharmacycopaytypes_pharmacytypefid_idx", using: :btree

  create_table "benefitstructurepharmacytype", force: :cascade do |t|
    t.string   "pharmacytype",    limit: 100,             null: false
    t.datetime "createtimestamp",                         null: false
    t.datetime "modifytimestamp",                         null: false
    t.integer  "active",                      default: 1, null: false
  end

  create_table "benefitstructurestate", force: :cascade do |t|
    t.integer "benefitstructurefid", null: false
    t.integer "statefid",            null: false
  end

  add_index "benefitstructurestate", ["benefitstructurefid", "statefid"], name: "benefitstructurestate_structure_state_idx", unique: true, using: :btree
  add_index "benefitstructurestate", ["benefitstructurefid"], name: "benefitstructurestate_structure_idx", using: :btree
  add_index "benefitstructurestate", ["statefid"], name: "benefitstructurestate_state_idx", using: :btree

  create_table "bl_admin_plan_name_logs", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "health_plan_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_admin_plan_name_notes", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "health_plan_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2009-12-29 17:00:25'
    t.datetime "updated_at",                              default: '2009-12-29 17:00:25'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
    t.integer  "analytics_header_type",                   default: 0
    t.string   "additional_site_drug_list",   limit: 255
    t.integer  "msa_id"
    t.string   "ordered_drug_list",           limit: 255
    t.boolean  "display_copay",                           default: false
  end

  add_index "bl_formularies", ["drug_class_id"], name: "bl_formularies_drug_class_id_idx", using: :btree
  add_index "bl_formularies", ["site_user_id"], name: "bl_formularies_site_user_id_idx", using: :btree
  add_index "bl_formularies", ["state_id"], name: "bl_formularies_state_id_idx", using: :btree
  add_index "bl_formularies", ["template"], name: "bl_formularies_template_idx", using: :btree

  create_table "bl_formulary_plan_settings", force: :cascade do |t|
    t.integer  "bl_formulary_id"
    t.integer  "health_plan_id"
    t.boolean  "highlight",       default: false
    t.boolean  "bold",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_msa_names", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.integer  "msa_id",                 null: false
    t.string   "name",       limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "formulary_table_name", limit: 255
    t.integer  "formulary_table_id"
    t.string   "environment",          limit: 255
    t.string   "file_name",            limit: 255
    t.string   "pdf_unique_id",        limit: 255
  end

  create_table "bl_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "bl_plan_drug_options", ["created_by"], name: "bl_plan_drug_options_created_by_idx", using: :btree
  add_index "bl_plan_drug_options", ["updated_by"], name: "bl_plan_drug_options_updated_by_idx", using: :btree

  create_table "bl_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "bl_plan_drug_settings", ["created_by"], name: "bl_plan_drug_settings_created_by_idx", using: :btree
  add_index "bl_plan_drug_settings", ["drug_id"], name: "bl_plan_drug_settings_drug_id_idx", using: :btree
  add_index "bl_plan_drug_settings", ["healthplan_id"], name: "bl_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "bl_plan_drug_settings", ["plan_drug_option_id"], name: "bl_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "bl_plan_drug_settings", ["state_id"], name: "bl_plan_drug_settings_state_id_idx", using: :btree
  add_index "bl_plan_drug_settings", ["updated_by"], name: "bl_plan_drug_settings_updated_by_idx", using: :btree

  create_table "bl_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "bl_publisher_activity_report_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_publisher_activity_report_states", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_publisher_activity_report_templates", force: :cascade do |t|
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "template_id"
    t.string   "template_type",                limit: 255
  end

  create_table "bl_publisher_activity_reports", force: :cascade do |t|
    t.boolean  "use_preset_date"
    t.string   "preset_date",     limit: 255
    t.date     "end_date"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_roles", force: :cascade do |t|
    t.string   "role",                    limit: 200
    t.string   "description",             limit: 200
    t.integer  "adminonly",                           default: 0
    t.integer  "requires_approval",                   default: 0
    t.integer  "formulary_tables",                    default: 0
    t.integer  "analytics",                           default: 0
    t.integer  "active",                              default: 1
    t.datetime "created_at",                          default: '2009-12-29 17:00:24'
    t.datetime "updated_at",                          default: '2009-12-29 17:00:24'
    t.integer  "plan_options_management",             default: 0
    t.boolean  "publisher_reporting",                 default: true,                  null: false
    t.boolean  "alerts",                              default: false,                 null: false
  end

  create_table "bl_site_cross_auths", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "expires_date"
    t.string   "user_email",     limit: 128
    t.string   "user_name",      limit: 128
    t.string   "user_last_name", limit: 128
    t.string   "logout_url",     limit: 128
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_template_drug_competitors", force: :cascade do |t|
    t.integer  "ff_publisher_template_id"
    t.integer  "drug_id"
    t.integer  "competitor_drug_id"
    t.boolean  "active",                   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "bl_user_alerts", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.integer  "legacyfid"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "archived_at"
  end

  create_table "bl_user_import_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "user_import_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_user_import_users", force: :cascade do |t|
    t.integer  "user_import_id"
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.string   "email",          limit: 255
    t.string   "ff_role",        limit: 255
    t.string   "password",       limit: 255
    t.string   "import_action",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_user_imports", force: :cascade do |t|
    t.integer  "site_user_id"
    t.string   "import_type",         limit: 255
    t.string   "notification_method", limit: 255
    t.string   "roster_file_name",    limit: 255
    t.string   "roster_content_type", limit: 255
    t.integer  "roster_file_size"
    t.datetime "roster_updated_at"
    t.datetime "imported_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bl_user_services", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid"
    t.integer "drugclassfid"
  end

  create_table "bl_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2009-12-29 17:00:25'
    t.datetime "last_accessed_timestamp",             default: '2009-12-29 17:00:25'
  end

  create_table "bl_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "bms_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "sa_formulary_id"
    t.boolean  "copied_to_sa",                            default: false
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: "now()"
    t.datetime "updated_at",                              default: "now()"
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.integer  "county_id"
    t.integer  "msa_id"
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
    t.integer  "custom_header_option",                    default: 1
    t.boolean  "include_state_percentage",                default: true
    t.string   "pbm_plans_order_list",        limit: 255
    t.string   "selected_health_plan_types",  limit: 255
    t.boolean  "display_tier_status",                     default: true
    t.integer  "custom_sub_header_option",                default: 1
    t.string   "hospital_ids",                limit: 255
    t.string   "custom_message",              limit: 255, default: ""
  end

  add_index "bms_formularies", ["drug_class_id"], name: "bms_formularies_drug_class_id_idx", using: :btree
  add_index "bms_formularies", ["site_user_id"], name: "bms_formularies_site_user_id_idx", using: :btree
  add_index "bms_formularies", ["state_id"], name: "bms_formularies_state_id_idx", using: :btree
  add_index "bms_formularies", ["template"], name: "bms_formularies_template_idx", using: :btree

  create_table "bms_formulary_approvals", force: :cascade do |t|
    t.integer  "formulary_id"
    t.integer  "user_id"
    t.datetime "created_at",               default: "now()"
    t.datetime "updated_at",               default: "now()"
    t.string   "name",         limit: 100
    t.string   "company",      limit: 100
  end

  create_table "bms_formulary_exports", force: :cascade do |t|
    t.integer  "formulary_id"
    t.datetime "created_at",                 default: "now()"
    t.string   "user_name",      limit: 255
    t.string   "territory",      limit: 255
    t.string   "client_user_id", limit: 255
  end

  create_table "bms_formulary_order_addresses", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "user_id"
    t.integer  "formulary_order_id"
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "address_1",          limit: 255
    t.string   "address_2",          limit: 255
    t.string   "city",               limit: 255
    t.integer  "state_id"
    t.string   "zip_code",           limit: 255
    t.string   "telephone_1",        limit: 255
    t.string   "telephone_2",        limit: 255
    t.string   "telephone_3",        limit: 255
    t.string   "telephone_4",        limit: 255
    t.string   "email",              limit: 255
    t.boolean  "store",                          default: false
  end

  create_table "bms_formulary_order_defaults", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at",            default: "now()"
    t.datetime "updated_at",            default: "now()"
    t.integer  "max_quantity"
    t.integer  "publisher_template_id"
  end

  create_table "bms_formulary_orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "formulary_id"
    t.integer  "quantity"
    t.boolean  "special_dl",               default: false
    t.integer  "lock_version",             default: 0
    t.string   "pdf_file",     limit: 255,                   null: false
    t.boolean  "order_sent",               default: false,   null: false
    t.boolean  "order_ftp",                default: false,   null: false
    t.datetime "created_at",               default: "now()"
    t.datetime "updated_at",               default: "now()"
  end

  create_table "bms_formulary_table_options", force: :cascade do |t|
    t.integer  "formulary_table_id"
    t.integer  "accompanying_formulary_table_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bms_hospital_import_hospitals", force: :cascade do |t|
    t.integer  "bms_hospital_import_id"
    t.string   "hcos_id",                limit: 255
    t.string   "name",                   limit: 255
    t.string   "import_action",          limit: 255
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bms_hospital_imports", force: :cascade do |t|
    t.integer  "bms_user_id"
    t.string   "roster_file_name",    limit: 255
    t.string   "roster_content_type", limit: 255
    t.datetime "roster_updated_at"
    t.datetime "imported_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bms_hospitals", force: :cascade do |t|
    t.string   "hcos_id",    limit: 255
    t.string   "name",       limit: 255
    t.integer  "state_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bms_ip_access", force: :cascade do |t|
    t.integer  "active",                  default: 1
    t.datetime "created_at",              default: "now()"
    t.datetime "updated_at"
    t.string   "ip",          limit: 255
    t.string   "description", limit: 255
  end

  create_table "bms_msa_names", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",             default: "now()"
    t.datetime "updated_at",             default: "now()"
    t.integer  "msa_id"
    t.string   "name",       limit: 100
    t.boolean  "active",                 default: true
  end

  create_table "bms_ordering_tool_orders", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                  limit: 255
    t.integer  "site_formulary_table_id"
    t.integer  "created_by_user_id"
    t.integer  "quantity"
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "address_line_1",          limit: 255
    t.string   "address_line_2",          limit: 255
    t.string   "city",                    limit: 255
    t.string   "state",                   limit: 255
    t.string   "zip_code",                limit: 255
    t.string   "telephone",               limit: 255
    t.string   "email",                   limit: 255
    t.integer  "searchable_order_id"
    t.string   "footer_code",             limit: 255
  end

  create_table "bms_ordering_tool_template_quantities", force: :cascade do |t|
    t.integer  "ff_publisher_template_id"
    t.integer  "site_role_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bms_pdf_access_archive", force: :cascade do |t|
    t.datetime "created_at",                default: "now()"
    t.integer  "active",                    default: 1
    t.integer  "user_id"
    t.integer  "formulary_id"
    t.string   "access_method", limit: 255
    t.string   "file_path",     limit: 255
    t.string   "file_name",     limit: 255
  end

  create_table "bms_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "user_id"
    t.datetime "created_at",    default: "now()"
    t.datetime "updated_at",    default: "now()"
    t.boolean  "exclude",       default: false
    t.boolean  "bold",          default: false
    t.boolean  "highlight",     default: false
  end

  add_index "bms_plan_drug_settings", ["drug_id"], name: "bms_plan_drug_settings_drug_id_idx", using: :btree
  add_index "bms_plan_drug_settings", ["healthplan_id"], name: "bms_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "bms_plan_drug_settings", ["state_id"], name: "bms_plan_drug_settings_state_id_idx", using: :btree
  add_index "bms_plan_drug_settings", ["user_id"], name: "bms_plan_drug_settings_site_user_id_idx", using: :btree

  create_table "bms_plan_names", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                default: "now()"
    t.datetime "updated_at",                default: "now()"
    t.integer  "healthplan_id"
    t.string   "name",          limit: 100
  end

  create_table "bms_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at",         default: "now()"
    t.datetime "updated_at",         default: "now()"
    t.integer  "updated_by_user_id"
  end

  add_index "bms_plan_tier_labels", ["healthplan_id"], name: "bms_plan_tier_labels_healthplan_id_idx", using: :btree
  add_index "bms_plan_tier_labels", ["tier_id"], name: "bms_plan_tier_labels_tier_id_idx", using: :btree
  add_index "bms_plan_tier_labels", ["tier_label_id"], name: "bms_plan_tier_labels_tier_label_id_idx", using: :btree

  create_table "bms_provider_rollup", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "user_id"
    t.datetime "created_at",  default: "now()"
    t.datetime "updated_at",  default: "now()"
    t.boolean  "show_footer", default: true
  end

  create_table "bms_provider_rollup_footers", force: :cascade do |t|
    t.boolean  "active",      default: true
    t.integer  "provider_id"
    t.boolean  "show_footer", default: true
    t.datetime "created_at",  default: "now()"
    t.datetime "updated_at",  default: "now()"
    t.integer  "user_id"
  end

  create_table "bms_restriction_code_display", force: :cascade do |t|
    t.integer "criteria_id"
    t.integer "qualifier_id"
    t.integer "display"
  end

  create_table "bms_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.datetime "created_at",                    default: "now()"
    t.datetime "updated_at",                    default: "now()"
    t.integer  "reporting",                     default: 0
    t.integer  "restrictions",                  default: 0
    t.integer  "accounts",                      default: 0
    t.boolean  "is_super_user",                 default: false
    t.boolean  "abilify_ordering",              default: false
    t.boolean  "alerts",                        default: false
    t.boolean  "request_account",               default: false
    t.boolean  "manage_users",                  default: false
  end

  create_table "bms_sales_forces", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                 default: true
  end

  create_table "bms_site_user_available_order_quantities", force: :cascade do |t|
    t.integer "quantity"
    t.integer "site_user_id"
    t.integer "ff_publisher_template_id"
  end

  create_table "bms_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "bms_user_alerts", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.integer  "legacyfid"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "archived_at"
  end

  create_table "bms_user_import_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "user_import_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bms_user_import_users", force: :cascade do |t|
    t.integer  "user_import_id"
    t.string   "first_name",     limit: 255
    t.string   "last_name",      limit: 255
    t.string   "email",          limit: 255
    t.string   "ff_role",        limit: 255
    t.string   "password",       limit: 255
    t.string   "import_action",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "extra_info"
  end

  create_table "bms_user_imports", force: :cascade do |t|
    t.integer  "site_user_id"
    t.string   "import_type",         limit: 255
    t.string   "notification_method", limit: 255
    t.string   "roster_file_name",    limit: 255
    t.string   "roster_content_type", limit: 255
    t.integer  "roster_file_size"
    t.datetime "roster_updated_at"
    t.datetime "imported_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bms_user_service_backups", id: false, force: :cascade do |t|
    t.integer "entityid"
    t.integer "userfid"
    t.integer "drugclassfid"
  end

  create_table "bms_user_services", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid"
    t.integer "drugclassfid"
  end

  create_table "bms_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: "now()"
    t.datetime "last_accessed_timestamp",             default: "now()"
  end

  create_table "bms_user_templates_orders_reports", force: :cascade do |t|
    t.string   "date_type",         limit: 255, default: "preset"
    t.string   "preset_date",       limit: 255, default: "all"
    t.date     "custom_start_date"
    t.date     "custom_end_date"
    t.boolean  "limit_to_orders",               default: false
    t.boolean  "all_states",                    default: true
    t.string   "state_ids",         limit: 255
    t.boolean  "all_templates"
    t.string   "drug_template_ids", limit: 255
    t.boolean  "all_sales_forces",              default: true
    t.text     "sales_force_ids"
    t.string   "region_name",       limit: 255
    t.string   "district_name",     limit: 255
    t.string   "sort_field",        limit: 255, default: "template_display_name"
    t.boolean  "sort_desc",                     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bms_users", force: :cascade do |t|
    t.string   "login",                   limit: 255
    t.string   "email",                   limit: 255
    t.string   "password",                limit: 40
    t.datetime "created_at",                          default: "now()"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at",                          default: "now()"
    t.string   "first_name",              limit: 200
    t.string   "last_name",               limit: 200
    t.integer  "role_id"
    t.integer  "active",                              default: 0
    t.integer  "approved",                            default: 0
    t.string   "activationkey",           limit: 50
    t.string   "client_user_id",          limit: 255
    t.text     "extra_info"
    t.string   "territory_function_code", limit: 255
    t.string   "sales_force_name",        limit: 255
    t.string   "region_name",             limit: 255
    t.string   "unit_type_id",            limit: 255
    t.string   "district_name",           limit: 255
    t.string   "role_code",               limit: 255
    t.string   "territory_code",          limit: 255
    t.string   "territory_name",          limit: 255
    t.integer  "sales_force_id"
  end

  create_table "cdi", force: :cascade do |t|
    t.integer  "drugfid",                    default: 0, null: false
    t.integer  "drugdisplayfid",             default: 0, null: false
    t.string   "drugname",       limit: 255
    t.integer  "dailymedid",                 default: 0, null: false
    t.string   "ndc",            limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "active",                     default: 1, null: false
  end

  add_index "cdi", ["dailymedid"], name: "cdi_dailymedid_idx", using: :btree
  add_index "cdi", ["drugdisplayfid"], name: "cdi_drugdisplayfid_idx", using: :btree
  add_index "cdi", ["drugfid"], name: "cdi_drugfid_idx", using: :btree
  add_index "cdi", ["ndc"], name: "cdi_ndc_idx", using: :btree

  create_table "celgenerole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "celgeneuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "celgeneuser", ["email"], name: "celgeneuser_email_key", unique: true, using: :btree

  create_table "celgeneusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "cephalon_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2009-02-04 11:29:42'
    t.datetime "updated_at",                              default: '2009-02-04 11:29:42'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "cephalon_formularies", ["drug_class_id"], name: "cephalon_formularies_drug_class_id_idx", using: :btree
  add_index "cephalon_formularies", ["site_user_id"], name: "cephalon_formularies_site_user_id_idx", using: :btree
  add_index "cephalon_formularies", ["state_id"], name: "cephalon_formularies_state_id_idx", using: :btree
  add_index "cephalon_formularies", ["template"], name: "cephalon_formularies_template_idx", using: :btree

  create_table "cephalon_ordering_tool_line_items", force: :cascade do |t|
    t.integer  "ordering_tool_user_id"
    t.integer  "ordering_tool_order_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cephalon_ordering_tool_orders", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",             limit: 255
    t.integer  "formulary_table_id"
    t.integer  "created_by_user_id"
  end

  create_table "cephalon_ordering_tool_template_quantities", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.integer  "site_role_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cephalon_ordering_tool_users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address1",     limit: 255
    t.string   "address2",     limit: 255
    t.string   "territory",    limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "postal_code",  limit: 255
    t.string   "phone",        limit: 255
    t.string   "type",         limit: 255
    t.string   "region",       limit: 255
    t.string   "title",        limit: 255
    t.string   "territory_id", limit: 255
    t.boolean  "active",                   default: true
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "email",        limit: 255
  end

  create_table "cephalon_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "publisher_formulary_name", limit: 255
    t.integer  "publisher_formulary_id"
    t.string   "environment",              limit: 255
    t.string   "file_name",                limit: 255
    t.string   "pdf_unique_id",            limit: 255
  end

  create_table "cephalon_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "site_user_id"
    t.datetime "created_at",    default: '2009-02-04 11:29:42'
    t.datetime "updated_at",    default: '2009-02-04 11:29:42'
    t.boolean  "exclude",       default: false
    t.boolean  "bold",          default: false
    t.boolean  "highlight",     default: false
  end

  add_index "cephalon_plan_drug_settings", ["drug_id"], name: "cephalon_plan_drug_settings_drug_id_idx", using: :btree
  add_index "cephalon_plan_drug_settings", ["healthplan_id"], name: "cephalon_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "cephalon_plan_drug_settings", ["site_user_id"], name: "cephalon_plan_drug_settings_site_user_id_idx", using: :btree
  add_index "cephalon_plan_drug_settings", ["state_id"], name: "cephalon_plan_drug_settings_state_id_idx", using: :btree

  create_table "cephalon_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cephalon_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at",         default: '2009-02-04 11:29:42'
    t.datetime "updated_at",         default: '2009-02-04 11:29:42'
    t.integer  "updated_by_user_id"
  end

  create_table "cephalon_publisher_formularies", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.string   "current_step",                limit: 255
    t.string   "name",                        limit: 255
    t.string   "competitor_drug_ids",         limit: 255, default: ""
    t.integer  "state_id"
    t.string   "geographic_customization",    limit: 255
    t.string   "health_plan_types",           limit: 255, default: ""
    t.string   "commercial_health_plan_ids",  limit: 255, default: ""
    t.string   "medicare_health_plan_ids",    limit: 255, default: ""
    t.string   "medicaid_health_plan_ids",    limit: 255, default: ""
    t.string   "bolded_health_plan_ids",      limit: 255, default: ""
    t.string   "highlighted_health_plan_ids", limit: 255, default: ""
    t.integer  "header_type"
    t.integer  "version"
    t.boolean  "is_active",                               default: true
    t.boolean  "is_published",                            default: false
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cephalon_publisher_templates", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "klass_name",                limit: 255
    t.string   "spotlight_drug_ids",        limit: 255, default: ""
    t.string   "competitor_drug_ids",       limit: 255, default: ""
    t.integer  "health_plan_count_min"
    t.integer  "health_plan_count_max"
    t.integer  "competitor_drug_count_min"
    t.integer  "competitor_drug_count_max"
    t.string   "allowed_role_ids",          limit: 255, default: ""
    t.boolean  "is_active",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "display_copay",                         default: false
  end

  create_table "cephalon_roles", force: :cascade do |t|
    t.string   "role",                limit: 200
    t.string   "description",         limit: 200
    t.integer  "adminonly",                       default: 0
    t.integer  "requires_approval",               default: 0
    t.integer  "formulary_tables",                default: 0
    t.integer  "analytics",                       default: 0
    t.integer  "active",                          default: 1
    t.datetime "created_at",                      default: '2009-02-04 11:29:41'
    t.datetime "updated_at",                      default: '2009-02-04 11:29:41'
    t.integer  "order_tables"
    t.boolean  "publisher_reporting",             default: false
  end

  create_table "cephalon_territory_state_mappings", force: :cascade do |t|
    t.string  "territory_id", limit: 255
    t.integer "state_id"
  end

  create_table "cephalon_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: '2009-02-04 11:29:42'
    t.datetime "updated_at",                      default: '2009-02-04 11:29:42'
  end

  create_table "cephalon_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2009-02-04 11:29:42'
    t.datetime "last_accessed_timestamp",             default: '2009-02-04 11:29:42'
  end

  create_table "cephalon_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at",                default: '2009-02-04 11:29:42'
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "clients_products", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "is_client",              default: false, null: false
    t.boolean  "is_product",             default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_plans", force: :cascade do |t|
    t.string  "contract_number",       limit: 255,                 null: false
    t.string  "plan_number",           limit: 255
    t.string  "organization_type",     limit: 255
    t.string  "plan_type",             limit: 255
    t.string  "name",                  limit: 255
    t.string  "marketing_name",        limit: 255
    t.string  "cpsc_name",             limit: 255
    t.string  "parent_organization",   limit: 255
    t.date    "contract_effective_at"
    t.boolean "offers_part_d",                     default: false
    t.boolean "is_snp_plan",                       default: false
    t.boolean "is_eghp",                           default: false
    t.boolean "active",                            default: true
    t.text    "notes"
  end

  add_index "cms_plans", ["contract_number", "plan_number"], name: "index_cms_plans_on_contract_number_and_plan_number", using: :btree
  add_index "cms_plans", ["contract_number"], name: "index_cms_plans_on_contract_number", using: :btree

  create_table "cms_plans_health_plans", force: :cascade do |t|
    t.integer "cms_plan_id",    null: false
    t.integer "health_plan_id", null: false
  end

  add_index "cms_plans_health_plans", ["cms_plan_id", "health_plan_id"], name: "index_cms_plans_health_plans_on_cms_plan_id_and_health_plan_id", using: :btree

  create_table "comment", force: :cascade do |t|
    t.text "comment", null: false
  end

  create_table "contact", force: :cascade do |t|
    t.boolean "isactive",                   null: false
    t.string  "contact",        limit: 255, null: false
    t.integer "contacttypefid",             null: false
  end

  create_table "contacttype", force: :cascade do |t|
    t.boolean "isactive",             null: false
    t.string  "name",     limit: 255, null: false
    t.boolean "isurl",                null: false
    t.boolean "isemail",              null: false
    t.boolean "isphone",              null: false
  end

  add_index "contacttype", ["name"], name: "contacttype_name_key", unique: true, using: :btree

  create_table "corporate_structure", force: :cascade do |t|
    t.string  "name",    limit: 200, null: false
    t.integer "orderid",             null: false
  end

  create_table "country", force: :cascade do |t|
    t.boolean "isactive",                 null: false
    t.string  "name",         limit: 255, null: false
    t.string  "abbreviation", limit: 10,  null: false
  end

  add_index "country", ["abbreviation"], name: "country_abbreviation_key", unique: true, using: :btree
  add_index "country", ["name"], name: "country_name_key", unique: true, using: :btree

  create_table "county", force: :cascade do |t|
    t.string  "name",         limit: 200,             null: false
    t.integer "fipsid"
    t.integer "statefid",                             null: false
    t.integer "msafid"
    t.integer "population",               default: 0, null: false
    t.string  "fusionmapsid", limit: 3
  end

  add_index "county", ["fipsid"], name: "county_fipsid_idx", using: :btree
  add_index "county", ["msafid"], name: "county_msafid_idx", using: :btree
  add_index "county", ["statefid"], name: "county_statefid_idx", using: :btree

# Could not dump table "county_map_regions" because of following StandardError
#   Unknown type 'geometry' for column 'geom'

  create_table "county_maps", force: :cascade do |t|
    t.integer  "county_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "county_zipcode", force: :cascade do |t|
    t.integer "zipcodefid"
    t.integer "countyfid"
  end

  add_index "county_zipcode", ["countyfid"], name: "county_zipcode_countyfid", using: :btree
  add_index "county_zipcode", ["zipcodefid", "countyfid"], name: "county_zipcode_zipcodefid_countyfid", unique: true, using: :btree
  add_index "county_zipcode", ["zipcodefid"], name: "county_zipcode_zipcodefid", unique: true, using: :btree

  create_table "countylives_batch", force: :cascade do |t|
    t.integer  "providerfid",                                  null: false
    t.integer  "statefid",                                     null: false
    t.integer  "countyfid",                                    null: false
    t.integer  "lives",                                        null: false
    t.integer  "lives_netoutmedicare",             default: 0, null: false
    t.string   "countycode",           limit: 100
    t.datetime "modifytimestamp",                              null: false
  end

  create_table "countylives_importtype", force: :cascade do |t|
    t.string "name", limit: 25, null: false
    t.string "code", limit: 2,  null: false
  end

  create_table "criteria", force: :cascade do |t|
    t.integer  "qualifierfid",                                  null: false
    t.string   "name",               limit: 200,                null: false
    t.string   "explanationtext",    limit: 255
    t.integer  "rangeflag",                                     null: false
    t.string   "notes",              limit: 255
    t.datetime "lastupdate",                                    null: false
    t.integer  "lastupdateffuserid",                            null: false
    t.boolean  "isactive",                       default: true, null: false
  end

  add_index "criteria", ["id"], name: "criteria_idx", using: :btree

  create_table "criteriaentry", force: :cascade do |t|
    t.integer  "criteriafid",                                    null: false
    t.text     "value_text"
    t.decimal  "value_numeric_start"
    t.integer  "value_numeric_end"
    t.string   "value_units",         limit: 255
    t.datetime "lastupdate",                                     null: false
    t.integer  "lastupdateffuserid",                             null: false
    t.boolean  "isactive",                        default: true, null: false
    t.string   "start_value_units",   limit: 255
  end

  add_index "criteriaentry", ["criteriafid"], name: "criteriaentry_criteria_idx", using: :btree
  add_index "criteriaentry", ["id"], name: "criteriaentry_idx", using: :btree

  create_table "cubist_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2011-06-09 13:50:01'
    t.datetime "updated_at",                              default: '2011-06-09 13:50:01'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "cubist_formularies", ["drug_class_id"], name: "cubist_formularies_drug_class_id_idx", using: :btree
  add_index "cubist_formularies", ["site_user_id"], name: "cubist_formularies_site_user_id_idx", using: :btree
  add_index "cubist_formularies", ["state_id"], name: "cubist_formularies_state_id_idx", using: :btree
  add_index "cubist_formularies", ["template"], name: "cubist_formularies_template_idx", using: :btree

  create_table "cubist_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "cubist_plan_drug_options", ["created_by"], name: "cubist_plan_drug_options_created_by_idx", using: :btree
  add_index "cubist_plan_drug_options", ["updated_by"], name: "cubist_plan_drug_options_updated_by_idx", using: :btree

  create_table "cubist_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "cubist_plan_drug_settings", ["created_by"], name: "cubist_plan_drug_settings_created_by_idx", using: :btree
  add_index "cubist_plan_drug_settings", ["drug_id"], name: "cubist_plan_drug_settings_drug_id_idx", using: :btree
  add_index "cubist_plan_drug_settings", ["healthplan_id"], name: "cubist_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "cubist_plan_drug_settings", ["plan_drug_option_id"], name: "cubist_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "cubist_plan_drug_settings", ["state_id"], name: "cubist_plan_drug_settings_state_id_idx", using: :btree
  add_index "cubist_plan_drug_settings", ["updated_by"], name: "cubist_plan_drug_settings_updated_by_idx", using: :btree

  create_table "cubist_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cubist_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cubist_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "cubist_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "accounts",                      default: 0
    t.integer  "active",                        default: 1
    t.boolean  "is_super_user",                 default: false
    t.datetime "created_at",                    default: '2011-06-09 13:50:00'
    t.datetime "updated_at",                    default: '2011-06-09 13:50:00'
  end

  create_table "cubist_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "cubist_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2011-06-09 13:50:01'
    t.datetime "last_accessed_timestamp",             default: '2011-06-09 13:50:01'
  end

  create_table "cubist_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "custom_territories_brand_groupings", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_territories_clients", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "schema_name", limit: 255
    t.integer  "ff_site_id"
    t.boolean  "active",                  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_territories_imports", force: :cascade do |t|
    t.string   "import_type",                 limit: 255
    t.integer  "brand_grouping_id"
    t.string   "territory_file_file_name",    limit: 255
    t.datetime "territory_file_updated_at"
    t.string   "territory_file_content_type", limit: 255
    t.integer  "territory_file_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "imported_at"
    t.string   "brand_grouping_name",         limit: 255
    t.integer  "client_id"
  end

  create_table "custom_territories_imports_zip_code_groups", force: :cascade do |t|
    t.integer  "import_id"
    t.integer  "zip_code_group_id"
    t.string   "status",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_feeds", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "schedule_frequency",     limit: 255
    t.string   "scope",                  limit: 255
    t.string   "job_id",                 limit: 255
    t.integer  "day_of_week"
    t.integer  "day_of_month"
    t.integer  "time_of_day"
    t.string   "feed_customer",          limit: 255
    t.text     "notes"
    t.string   "feed_file",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "upload_to_customer_ftp",             default: false
  end

  create_table "ddd_outlets", force: :cascade do |t|
    t.string  "outlet_key"
    t.string  "name"
    t.integer "county_id"
  end

  add_index "ddd_outlets", ["county_id"], name: "ddd_outlets_county_id", using: :btree
  add_index "ddd_outlets", ["outlet_key"], name: "ddd_outlets_outlet_key", using: :btree

  create_table "ddd_outlets_health_plans", force: :cascade do |t|
    t.integer "health_plan_id"
    t.integer "ddd_outlet_id"
  end

  add_index "ddd_outlets_health_plans", ["ddd_outlet_id", "health_plan_id"], name: "index_ddd_outlets_health_plans_on_ddd_outlet_id_and_health_plan", using: :btree
  add_index "ddd_outlets_health_plans", ["ddd_outlet_id"], name: "index_ddd_outlets_health_plans_on_ddd_outlet_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0
    t.integer  "attempts",               default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "demo_ims_geography_rollup_rx_counts", force: :cascade do |t|
    t.decimal "count_total",             null: false
    t.decimal "count_new",               null: false
    t.integer "imsfid",                  null: false
    t.string  "imsname",     limit: 255, null: false
    t.integer "imscode",     limit: 8,   null: false
    t.integer "drugfid",                 null: false
    t.string  "import_date", limit: 10
  end

  create_table "demo_ims_geography_rollup_rx_counts_staging", force: :cascade do |t|
    t.decimal "count_total",             null: false
    t.decimal "count_new",               null: false
    t.integer "imsfid",                  null: false
    t.string  "imsname",     limit: 255, null: false
    t.integer "imscode",     limit: 8,   null: false
    t.integer "drugfid",                 null: false
    t.string  "import_date", limit: 10
  end

  create_table "demo_ims_rx_counts", force: :cascade do |t|
    t.decimal "count_total",                             null: false
    t.decimal "count_new",                               null: false
    t.decimal "quantity_total",            default: 0.0, null: false
    t.decimal "quantity_new",              default: 0.0, null: false
    t.integer "imsfid"
    t.integer "drugfid",                                 null: false
    t.integer "planfid"
    t.integer "msafid"
    t.integer "statefid"
    t.integer "countyfid"
    t.string  "import_date",    limit: 10
  end

  create_table "demo_ims_rx_counts_staging", force: :cascade do |t|
    t.decimal "count_total",                             null: false
    t.decimal "count_new",                               null: false
    t.decimal "quantity_total",            default: 0.0, null: false
    t.decimal "quantity_new",              default: 0.0, null: false
    t.integer "imsfid"
    t.integer "drugfid",                                 null: false
    t.integer "planfid"
    t.integer "msafid"
    t.integer "statefid"
    t.integer "countyfid"
    t.string  "import_date",    limit: 10
  end

  create_table "demo_product_keys_drugs", id: false, force: :cascade do |t|
    t.string  "product_code",   limit: 3
    t.string  "product_name",   limit: 100
    t.integer "ff_display_id"
    t.string  "ff_drug_name",   limit: 100
    t.integer "drug_id"
    t.string  "submarket_code", limit: 3
  end

  create_table "demo_product_keys_drugs_staging", id: false, force: :cascade do |t|
    t.string  "product_code",   limit: 3
    t.string  "product_name",   limit: 100
    t.integer "ff_display_id"
    t.string  "ff_drug_name",   limit: 100
    t.integer "drug_id"
    t.string  "submarket_code", limit: 3
  end

  create_table "demo_rx_raw_ims_facts_staging", id: false, force: :cascade do |t|
    t.integer "plan_number",    limit: 8
    t.string  "product_family", limit: 3
    t.string  "zip",            limit: 5
    t.string  "calendar_month", limit: 6
    t.decimal "total_scripts"
    t.decimal "new_scripts"
    t.integer "drug_id"
    t.integer "zipcode_id"
    t.integer "county_id"
    t.integer "msa_id"
    t.integer "state_id"
    t.integer "ims_id"
    t.string  "import_date",    limit: 10
  end

  create_table "dey_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2011-02-10 15:08:20'
    t.datetime "updated_at",                              default: '2011-02-10 15:08:20'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "dey_formularies", ["drug_class_id"], name: "dey_formularies_drug_class_id_idx", using: :btree
  add_index "dey_formularies", ["site_user_id"], name: "dey_formularies_site_user_id_idx", using: :btree
  add_index "dey_formularies", ["state_id"], name: "dey_formularies_state_id_idx", using: :btree
  add_index "dey_formularies", ["template"], name: "dey_formularies_template_idx", using: :btree

  create_table "dey_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "dey_plan_drug_options", ["created_by"], name: "dey_plan_drug_options_created_by_idx", using: :btree
  add_index "dey_plan_drug_options", ["updated_by"], name: "dey_plan_drug_options_updated_by_idx", using: :btree

  create_table "dey_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "dey_plan_drug_settings", ["created_by"], name: "dey_plan_drug_settings_created_by_idx", using: :btree
  add_index "dey_plan_drug_settings", ["drug_id"], name: "dey_plan_drug_settings_drug_id_idx", using: :btree
  add_index "dey_plan_drug_settings", ["healthplan_id"], name: "dey_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "dey_plan_drug_settings", ["plan_drug_option_id"], name: "dey_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "dey_plan_drug_settings", ["state_id"], name: "dey_plan_drug_settings_state_id_idx", using: :btree
  add_index "dey_plan_drug_settings", ["updated_by"], name: "dey_plan_drug_settings_updated_by_idx", using: :btree

  create_table "dey_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dey_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dey_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "dey_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "accounts",                      default: 0
    t.integer  "restrictions",                  default: 0
    t.integer  "alerts",                        default: 0
    t.integer  "active",                        default: 1
    t.boolean  "is_super_user",                 default: false
    t.datetime "created_at",                    default: '2011-02-10 15:08:16'
    t.datetime "updated_at",                    default: '2011-02-10 15:08:16'
  end

  create_table "dey_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "dey_user_services_providers", id: false, force: :cascade do |t|
    t.integer "site_user_service_id"
    t.integer "provider_id"
  end

  create_table "dey_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2011-02-10 15:08:20'
    t.datetime "last_accessed_timestamp",             default: '2011-02-10 15:08:20'
  end

  create_table "dey_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "deyuseralert", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.integer  "legacyfid"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "archived_at"
  end

  create_table "deyuserservice", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid",      null: false
    t.integer "drugclassfid"
  end

  create_table "diovan_address", id: :bigserial, force: :cascade do |t|
    t.integer  "addresstypefid",             default: 1,       null: false
    t.string   "address",        limit: 200
    t.string   "city",           limit: 200
    t.integer  "statefid"
    t.integer  "countryfid"
    t.string   "postalcode",     limit: 50
    t.string   "geocode",        limit: 50
    t.datetime "created",                    default: "now()", null: false
    t.integer  "active",                     default: 1,       null: false
  end

  create_table "diovan_address_user", id: :bigserial, force: :cascade do |t|
    t.integer "addressfid", limit: 8, null: false
    t.integer "userfid",    limit: 8, null: false
  end

  create_table "diovan_jobtype", force: :cascade do |t|
    t.string   "name",            limit: 100,                   null: false
    t.integer  "usertypefid",                                   null: false
    t.integer  "requireapproval",             default: 0,       null: false
    t.datetime "created",                     default: "now()", null: false
    t.integer  "active",                      default: 1,       null: false
  end

  create_table "diovan_jobtypepermission", id: :bigserial, force: :cascade do |t|
    t.integer  "jobtypefid",      limit: 8,                   null: false
    t.integer  "permissionfid",   limit: 8,                   null: false
    t.integer  "permissionvalue",                             null: false
    t.datetime "created",                   default: "now()", null: false
    t.integer  "createdby",       limit: 8,                   null: false
    t.datetime "modified",                                    null: false
    t.integer  "modifiedby",      limit: 8,                   null: false
    t.integer  "active",                    default: 1,       null: false
  end

  create_table "diovan_phone", force: :cascade do |t|
    t.integer  "phonetypefid",            default: 1,       null: false
    t.string   "number",       limit: 50,                   null: false
    t.string   "ext",          limit: 10
    t.datetime "created",                 default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "diovan_phone_user", id: :bigserial, force: :cascade do |t|
    t.integer "phonefid", limit: 8, null: false
    t.integer "userfid",  limit: 8, null: false
  end

  create_table "diovan_user", id: :bigserial, force: :cascade do |t|
    t.string   "email",             limit: 255,                   null: false
    t.string   "password",          limit: 255,                   null: false
    t.datetime "passwordtimestamp",             default: "now()", null: false
    t.string   "salutation",        limit: 10
    t.string   "firstname",         limit: 255,                   null: false
    t.string   "lastname",          limit: 255,                   null: false
    t.integer  "jobtypefid",                                      null: false
    t.string   "jobtypeother",      limit: 100
    t.string   "practicename",      limit: 100
    t.integer  "optin",                         default: 0,       null: false
    t.integer  "status",                        default: 0,       null: false
    t.integer  "access",                        default: 0,       null: false
    t.datetime "created",                       default: "now()", null: false
    t.integer  "createdby",         limit: 8,                     null: false
    t.datetime "modified",                                        null: false
    t.integer  "modifiedby",        limit: 8,                     null: false
    t.integer  "active",                        default: 1,       null: false
  end

  create_table "diovan_user_download", id: :bigserial, force: :cascade do |t|
    t.integer  "diovan_userfid",  limit: 8,   null: false
    t.string   "type",            limit: 10
    t.string   "version",         limit: 10
    t.datetime "lastupdate"
    t.string   "user_ip",         limit: 20
    t.string   "http_user_agent", limit: 200
    t.string   "http_host",       limit: 100
  end

  create_table "diovan_useralert", id: :bigserial, force: :cascade do |t|
    t.integer  "userfid",           limit: 8,                 null: false
    t.integer  "planfid",           limit: 8
    t.integer  "drugfid",           limit: 8
    t.integer  "drugclassfid",      limit: 8
    t.integer  "drugplanformfid",   limit: 8
    t.integer  "coveragestatusold", limit: 8
    t.integer  "coveragestatusnew", limit: 8
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.datetime "alerttimestamp",                              null: false
    t.datetime "createtimestamp",                             null: false
    t.boolean  "isemailsent",                 default: false, null: false
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
  end

  create_table "diovan_userdrug", force: :cascade do |t|
    t.integer "userfid", limit: 8, null: false
    t.integer "drugfid", limit: 8, null: false
  end

  add_index "diovan_userdrug", ["drugfid"], name: "diovan_userdrug_drugfid_idx", using: :btree
  add_index "diovan_userdrug", ["userfid"], name: "diovan_userdrug_userfid_idx", using: :btree

  create_table "diovan_userhealthplan", force: :cascade do |t|
    t.integer "userfid",       limit: 8, null: false
    t.integer "healthplanfid", limit: 8, null: false
    t.integer "statefid",                null: false
  end

  add_index "diovan_userhealthplan", ["healthplanfid"], name: "diovan_userhealthplan_healthplanfid_idx", using: :btree
  add_index "diovan_userhealthplan", ["userfid"], name: "diovan_userhealthplan_userfid_idx", using: :btree

  create_table "diovan_userservice", id: :bigserial, force: :cascade do |t|
    t.integer "userfid",      limit: 8, null: false
    t.integer "drugclassfid", limit: 8
  end

  create_table "diovan_usersession", id: :bigserial, force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.string   "sessionid",             limit: 200, null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                    null: false
    t.datetime "lastaccessedtimestamp",             null: false
  end

  create_table "dma", force: :cascade do |t|
    t.string   "dma_code",   limit: 3
    t.string   "dma_name",   limit: 100
    t.integer  "active",                 default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dma_state", force: :cascade do |t|
    t.integer  "dma_id"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dma_state", ["dma_id"], name: "dma_state_dma_id_idx", using: :btree
  add_index "dma_state", ["state_id"], name: "dma_state_state_id_idx", using: :btree

  create_table "dma_zipcode", force: :cascade do |t|
    t.integer  "dma_id"
    t.integer  "zipcode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dma_zipcode", ["dma_id"], name: "dma_zipcode_dma_id_idx", using: :btree
  add_index "dma_zipcode", ["zipcode_id"], name: "dma_zipcode_zipcode_id_idx", using: :btree

  create_table "drirole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",        limit: 8,   default: 0, null: false
    t.integer  "requiresapproval", limit: 8,   default: 0, null: false
    t.integer  "createtable",      limit: 8,   default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "driuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid",            limit: 8
    t.integer  "isactive",           limit: 8,   default: 0, null: false
    t.integer  "isalerts",           limit: 8,   default: 0, null: false
    t.integer  "isapproved",         limit: 8,   default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
    t.datetime "password_expires"
    t.datetime "account_expires"
  end

  add_index "driuser", ["email"], name: "driuser_email_key", unique: true, using: :btree

  create_table "driusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",               limit: 8,               null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",            limit: 8,   default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "drug", force: :cascade do |t|
    t.boolean  "isactive",                                              null: false
    t.boolean  "isgeneric",                                             null: false
    t.string   "name",                    limit: 255,                   null: false
    t.string   "chemicalname",            limit: 255,                   null: false
    t.string   "webname",                 limit: 255
    t.string   "rewritename",             limit: 255,                   null: false
    t.string   "bookname",                limit: 255
    t.integer  "manufacturerfid"
    t.integer  "genericdrugfid"
    t.string   "informationurl",          limit: 255
    t.datetime "fdaverifydate"
    t.integer  "legacyfid"
    t.datetime "createtimestamp",                     default: "now()", null: false
    t.datetime "lastupdate"
    t.integer  "lastupdateffuserfid"
    t.integer  "displayid",                           default: 0,       null: false
    t.integer  "druglabelfid"
    t.integer  "isfeatured",                          default: 0,       null: false
    t.integer  "is_multi_source",                     default: 0,       null: false
    t.text     "strengths"
    t.text     "notes"
    t.boolean  "global_na_default",                   default: false
    t.boolean  "is_medical_benefits",                 default: false
    t.boolean  "is_injectable",                       default: false
    t.boolean  "global_nc_rc_40_default",             default: false,   null: false
    t.boolean  "is_pa_form",                          default: false,   null: false
  end

  add_index "drug", ["displayid"], name: "drug_displayid_unique", unique: true, using: :btree
  add_index "drug", ["isactive"], name: "drug_isactive", using: :btree
  add_index "drug", ["name"], name: "drug_name_key", unique: true, using: :btree
  add_index "drug", ["rewritename"], name: "drug_rewritename_key", unique: true, using: :btree
  add_index "drug", ["webname"], name: "drug_webname", using: :btree

  create_table "drug_prior_authorization_forms", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "health_plan_type_aggregate_id"
    t.integer  "drug_id"
    t.string   "url",                           limit: 255
    t.datetime "created_at",                                default: "now()"
    t.datetime "updated_at",                                default: "now()"
  end

  create_table "drug_resources", force: :cascade do |t|
    t.integer  "drug_id"
    t.text     "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drug_strengths", force: :cascade do |t|
    t.integer "drug_id"
    t.float   "quantity"
    t.string  "unit",     limit: 255
  end

  add_index "drug_strengths", ["drug_id"], name: "drug_id_idx", using: :btree

  create_table "drugclass", force: :cascade do |t|
    t.boolean  "isactive",                                    null: false
    t.string   "name",                limit: 255,             null: false
    t.string   "webname",             limit: 255,             null: false
    t.string   "rewritename",         limit: 255,             null: false
    t.string   "bookname",            limit: 255,             null: false
    t.integer  "legacyfid"
    t.datetime "lastupdate"
    t.integer  "lastupdateffuserfid"
    t.integer  "drugclassusetypefid",             default: 1, null: false
    t.string   "comments",            limit: 255
    t.string   "ehs_code_1",          limit: 3
    t.string   "ehs_code_2",          limit: 3
  end

  add_index "drugclass", ["name"], name: "drugclass_name_key", unique: true, using: :btree
  add_index "drugclass", ["rewritename"], name: "drugclass_rewritename_key", unique: true, using: :btree
  add_index "drugclass", ["webname"], name: "drugclass_webname_key", unique: true, using: :btree

  create_table "drugclasstherapeuticarea", force: :cascade do |t|
    t.integer "drugclassfid",       null: false
    t.integer "therapeuticareafid", null: false
  end

  add_index "drugclasstherapeuticarea", ["drugclassfid", "therapeuticareafid"], name: "drugclasstherapeuticarea_drugclassfid_key", unique: true, using: :btree

  create_table "drugcomment", force: :cascade do |t|
    t.integer "drugfid",    null: false
    t.integer "commentfid", null: false
  end

  add_index "drugcomment", ["drugfid", "commentfid"], name: "drugcomment_drugfid_key", unique: true, using: :btree

  create_table "drugdrugclass", force: :cascade do |t|
    t.integer "drugfid",      null: false
    t.integer "drugclassfid", null: false
  end

  add_index "drugdrugclass", ["drugfid", "drugclassfid"], name: "drugdrugclass_drugfid_key", unique: true, using: :btree

  create_table "drugfactor", force: :cascade do |t|
    t.integer "drugfid",   null: false
    t.integer "factorfid", null: false
  end

  add_index "drugfactor", ["drugfid", "factorfid"], name: "drugfactor_drugfid_key", unique: true, using: :btree
  add_index "drugfactor", ["drugfid"], name: "drugfactor_drugfid", using: :btree
  add_index "drugfactor", ["factorfid"], name: "drugfactor_factorfid", using: :btree

  create_table "druglabel", force: :cascade do |t|
    t.integer  "drugfid",                  default: 0,       null: false
    t.string   "labelkey",     limit: 255
    t.string   "labeldate",    limit: 20
    t.string   "title",        limit: 500
    t.string   "drugnames",    limit: 255
    t.string   "genericnames", limit: 255
    t.string   "codes",        limit: 255
    t.string   "manufacturer", limit: 255
    t.string   "images",       limit: 500
    t.string   "description",  limit: 500
    t.string   "matchcode",    limit: 10
    t.datetime "created",                  default: "now()", null: false
    t.datetime "modified",                                   null: false
    t.integer  "active",                   default: 1,       null: false
  end

  add_index "druglabel", ["drugfid"], name: "druglabel_drugfid_idx", using: :btree
  add_index "druglabel", ["drugnames"], name: "druglabel_drugfnames_idx", using: :btree

  create_table "drugplanformarchive", primary_key: "entityid", force: :cascade do |t|
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugformfid"
    t.integer  "coveragestatus",  default: 8
    t.boolean  "priorauth",       default: false
    t.boolean  "quantlimit",      default: false
    t.boolean  "stepther",        default: false
    t.datetime "createtimestamp",                 null: false
    t.integer  "resetflag",       default: 0
    t.boolean  "restrother",      default: false
    t.integer  "reasoncodefid",   default: 0,     null: false
    t.boolean  "preferred"
  end

  add_index "drugplanformarchive", ["drugfid"], name: "drugfid_idx", using: :btree
  add_index "drugplanformarchive", ["planfid", "drugfid", "resetflag", "createtimestamp"], name: "drugplanformarchive_planfid_drugfid_resetflag_createtimestamp_i", using: :btree
  add_index "drugplanformarchive", ["planfid", "drugfid"], name: "planfid_drugfid_idx", using: :btree
  add_index "drugplanformarchive", ["planfid"], name: "planfid_idx", using: :btree

  create_table "drugs_jcodes", force: :cascade do |t|
    t.integer  "drug_id"
    t.integer  "jcode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dsi_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2010-09-22 09:45:09'
    t.datetime "updated_at",                              default: '2010-09-22 09:45:09'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "dsi_formularies", ["drug_class_id"], name: "dsi_formularies_drug_class_id_idx", using: :btree
  add_index "dsi_formularies", ["site_user_id"], name: "dsi_formularies_site_user_id_idx", using: :btree
  add_index "dsi_formularies", ["state_id"], name: "dsi_formularies_state_id_idx", using: :btree
  add_index "dsi_formularies", ["template"], name: "dsi_formularies_template_idx", using: :btree

  create_table "dsi_pdf_access_logs", force: :cascade do |t|
    t.integer  "user_id",                                           null: false
    t.integer  "publisher_formulary_id"
    t.integer  "publisher_template_id"
    t.string   "pdf_unique_id",          limit: 32
    t.string   "relative_path",          limit: 500
    t.string   "file_name",              limit: 100
    t.string   "environment",            limit: 32
    t.string   "access_method",          limit: 50
    t.string   "http_referer",           limit: 500
    t.boolean  "active",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dsi_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "dsi_plan_drug_options", ["created_by"], name: "dsi_plan_drug_options_created_by_idx", using: :btree
  add_index "dsi_plan_drug_options", ["updated_by"], name: "dsi_plan_drug_options_updated_by_idx", using: :btree

  create_table "dsi_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "dsi_plan_drug_settings", ["created_by"], name: "dsi_plan_drug_settings_created_by_idx", using: :btree
  add_index "dsi_plan_drug_settings", ["drug_id"], name: "dsi_plan_drug_settings_drug_id_idx", using: :btree
  add_index "dsi_plan_drug_settings", ["healthplan_id"], name: "dsi_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "dsi_plan_drug_settings", ["plan_drug_option_id"], name: "dsi_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "dsi_plan_drug_settings", ["state_id"], name: "dsi_plan_drug_settings_state_id_idx", using: :btree
  add_index "dsi_plan_drug_settings", ["updated_by"], name: "dsi_plan_drug_settings_updated_by_idx", using: :btree

  create_table "dsi_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dsi_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dsi_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "dsi_publisher_templates", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "klass_name",            limit: 255
    t.string   "spotlight_drug_ids",    limit: 255
    t.string   "competitor_drug_ids",   limit: 255
    t.integer  "health_plan_count_min"
    t.integer  "health_plan_count_max"
    t.integer  "drug_count_min"
    t.integer  "drug_count_max"
    t.string   "allowed_role_ids",      limit: 255
    t.boolean  "is_active",                         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cf"
    t.integer  "drug_class_id"
    t.string   "template_dimensions",   limit: 255
  end

  create_table "dsi_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.boolean  "is_super_user",                 default: false
    t.datetime "created_at",                    default: '2010-09-22 09:45:09'
    t.datetime "updated_at",                    default: '2010-09-22 09:45:09'
  end

  create_table "dsi_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "dsi_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-09-22 09:45:09'
    t.datetime "last_accessed_timestamp",             default: '2010-09-22 09:45:09'
  end

  create_table "dsi_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "dsidrugplanform", primary_key: "entityid", force: :cascade do |t|
    t.integer "formularyfid",               null: false
    t.integer "planid",                     null: false
    t.integer "drugid",                     null: false
    t.integer "coveragestatus",             null: false
    t.boolean "priorauth",                  null: false
    t.boolean "quantlimit",                 null: false
    t.boolean "stepther",                   null: false
    t.integer "resetflag",      default: 0, null: false
    t.integer "paforall",       default: 0, null: false
  end

  create_table "dsiformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                             null: false
    t.integer  "statefid",                                            null: false
    t.integer  "drugclassfid",                                        null: false
    t.string   "planlist",                   limit: 1000,             null: false
    t.string   "druglist",                   limit: 100,              null: false
    t.string   "tabletype",                  limit: 10,               null: false
    t.string   "tableversion",               limit: 100,              null: false
    t.integer  "versionnumber",                           default: 0, null: false
    t.integer  "ispublished",                             default: 0, null: false
    t.integer  "isexported",                              default: 0, null: false
    t.integer  "isactive",                                default: 1, null: false
    t.integer  "mostrecent",                              default: 0, null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "createtimestamp",                                     null: false
    t.datetime "modifytimestamp",                                     null: false
    t.string   "planorderedlist",            limit: 500
    t.string   "template",                   limit: 50
    t.string   "current_step",               limit: 255
    t.string   "plan_type_list",             limit: 255
    t.integer  "publisher_template_id"
    t.string   "commercial_health_plan_ids", limit: 255
    t.string   "medicare_health_plan_ids",   limit: 255
    t.string   "medicaid_health_plan_ids",   limit: 255
    t.string   "health_plan_types",          limit: 255
    t.string   "name",                       limit: 255
    t.integer  "msa_id"
  end

  create_table "dsihealthplanexclude", force: :cascade do |t|
    t.integer  "planfid",                      null: false
    t.integer  "statefid",                     null: false
    t.datetime "modified",   default: "now()", null: false
    t.integer  "modifiedby"
    t.integer  "active",     default: 1,       null: false
  end

  add_index "dsihealthplanexclude", ["planfid"], name: "dsihealthplanexclude_planfid_idx", using: :btree
  add_index "dsihealthplanexclude", ["statefid"], name: "dsihealthplanexclude_statefid_idx", using: :btree

  create_table "dsiimshealthplan", force: :cascade do |t|
    t.integer "healthplanfid", null: false
    t.integer "imsfid",        null: false
  end

  add_index "dsiimshealthplan", ["healthplanfid", "imsfid"], name: "dsiimshealthplan_healthplanfid_key", unique: true, using: :btree

  create_table "dsiimsplan", force: :cascade do |t|
    t.string   "name",            limit: 255,                   null: false
    t.integer  "code",            limit: 8,                     null: false
    t.integer  "statefid"
    t.string   "model",           limit: 50,                    null: false
    t.text     "comments"
    t.integer  "payerid"
    t.string   "payername",       limit: 255
    t.datetime "createtimestamp",             default: "now()", null: false
    t.datetime "modifytimestamp"
    t.boolean  "isactive",                                      null: false
  end

  add_index "dsiimsplan", ["code"], name: "dsiimsplan_code_key", unique: true, using: :btree

  create_table "dsirole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",                limit: 20,                  null: false
    t.string   "description",         limit: 500
    t.integer  "adminonly",                       default: 0,     null: false
    t.integer  "requiresapproval",                default: 0,     null: false
    t.integer  "createtable",                     default: 0,     null: false
    t.integer  "manageuser",                      default: 0,     null: false
    t.datetime "createtimestamp",                                 null: false
    t.datetime "modifytimestamp",                                 null: false
    t.integer  "viewalltables",                   default: 0,     null: false
    t.integer  "searchtable",                     default: 0,     null: false
    t.integer  "viewanalytics",                   default: 0,     null: false
    t.integer  "view_formulary",      limit: 8,   default: 0,     null: false
    t.integer  "restrictions",                    default: 0
    t.integer  "active"
    t.boolean  "publisher_reporting",             default: false
    t.boolean  "is_super_user",                   default: false
  end

  create_table "dsiuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
    t.string   "territory",          limit: 15,              null: false
    t.integer  "allocationallowed",              default: 1
  end

  add_index "dsiuser", ["email"], name: "dsiuser_email_key", unique: true, using: :btree

  create_table "dsiuser_backup1", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.string   "email",              limit: 200
    t.string   "password",           limit: 200
    t.string   "firstname",          limit: 200
    t.string   "lastname",           limit: 200
    t.integer  "rolefid"
    t.integer  "isactive"
    t.integer  "isalerts"
    t.integer  "isapproved"
    t.string   "activationkey",      limit: 50
    t.datetime "createtimestamp"
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp"
    t.string   "territory",          limit: 15
    t.integer  "allocationallowed"
  end

  create_table "dsiuser_backup2", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.string   "email",              limit: 200
    t.string   "password",           limit: 200
    t.string   "firstname",          limit: 200
    t.string   "lastname",           limit: 200
    t.integer  "rolefid"
    t.integer  "isactive"
    t.integer  "isalerts"
    t.integer  "isapproved"
    t.string   "activationkey",      limit: 50
    t.datetime "createtimestamp"
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp"
    t.string   "territory",          limit: 15
    t.integer  "allocationallowed"
  end

  create_table "dsiuser_backup3", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.string   "email",              limit: 200
    t.string   "password",           limit: 200
    t.string   "firstname",          limit: 200
    t.string   "lastname",           limit: 200
    t.integer  "rolefid"
    t.integer  "isactive"
    t.integer  "isalerts"
    t.integer  "isapproved"
    t.string   "activationkey",      limit: 50
    t.datetime "createtimestamp"
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp"
    t.string   "territory",          limit: 15
    t.integer  "allocationallowed"
  end

  create_table "dsiuser_backup4", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.string   "email",              limit: 200
    t.string   "password",           limit: 200
    t.string   "firstname",          limit: 200
    t.string   "lastname",           limit: 200
    t.integer  "rolefid"
    t.integer  "isactive"
    t.integer  "isalerts"
    t.integer  "isapproved"
    t.string   "activationkey",      limit: 50
    t.datetime "createtimestamp"
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp"
    t.string   "territory",          limit: 15
    t.integer  "allocationallowed"
  end

  create_table "dsiuser_backup5", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.string   "email",              limit: 200
    t.string   "password",           limit: 200
    t.string   "firstname",          limit: 200
    t.string   "lastname",           limit: 200
    t.integer  "rolefid"
    t.integer  "isactive"
    t.integer  "isalerts"
    t.integer  "isapproved"
    t.string   "activationkey",      limit: 50
    t.datetime "createtimestamp"
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp"
    t.string   "territory",          limit: 15
    t.integer  "allocationallowed"
  end

  create_table "dsiuser_backup6", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.string   "email",              limit: 200
    t.string   "password",           limit: 200
    t.string   "firstname",          limit: 200
    t.string   "lastname",           limit: 200
    t.integer  "rolefid"
    t.integer  "isactive"
    t.integer  "isalerts"
    t.integer  "isapproved"
    t.string   "activationkey",      limit: 50
    t.datetime "createtimestamp"
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp"
    t.string   "territory",          limit: 15
    t.integer  "allocationallowed"
  end

  create_table "dsiuser_backup7", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.string   "email",              limit: 200
    t.string   "password",           limit: 200
    t.string   "firstname",          limit: 200
    t.string   "lastname",           limit: 200
    t.integer  "rolefid"
    t.integer  "isactive"
    t.integer  "isalerts"
    t.integer  "isapproved"
    t.string   "activationkey",      limit: 50
    t.datetime "createtimestamp"
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp"
    t.string   "territory",          limit: 15
    t.integer  "allocationallowed"
  end

  create_table "dsiuseralert", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
  end

  create_table "dsiuserservice", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid",      null: false
    t.integer "drugclassfid"
  end

  create_table "dsiusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "eisai_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2010-07-27 10:57:37'
    t.datetime "updated_at",                              default: '2010-07-27 10:57:37'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
    t.string   "highlight_plan_list",         limit: 255
    t.string   "bold_plan_list",              limit: 255
  end

  add_index "eisai_formularies", ["drug_class_id"], name: "eisai_formularies_drug_class_id_idx", using: :btree
  add_index "eisai_formularies", ["site_user_id"], name: "eisai_formularies_site_user_id_idx", using: :btree
  add_index "eisai_formularies", ["state_id"], name: "eisai_formularies_state_id_idx", using: :btree
  add_index "eisai_formularies", ["template"], name: "eisai_formularies_template_idx", using: :btree

  create_table "eisai_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "formulary_table_name", limit: 255
    t.integer  "formulary_table_id"
    t.string   "environment",          limit: 255
    t.string   "file_name",            limit: 255
    t.string   "pdf_unique_id",        limit: 255
  end

  create_table "eisai_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "eisai_plan_drug_options", ["created_by"], name: "eisai_plan_drug_options_created_by_idx", using: :btree
  add_index "eisai_plan_drug_options", ["updated_by"], name: "eisai_plan_drug_options_updated_by_idx", using: :btree

  create_table "eisai_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "eisai_plan_drug_settings", ["created_by"], name: "eisai_plan_drug_settings_created_by_idx", using: :btree
  add_index "eisai_plan_drug_settings", ["drug_id"], name: "eisai_plan_drug_settings_drug_id_idx", using: :btree
  add_index "eisai_plan_drug_settings", ["healthplan_id"], name: "eisai_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "eisai_plan_drug_settings", ["plan_drug_option_id"], name: "eisai_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "eisai_plan_drug_settings", ["state_id"], name: "eisai_plan_drug_settings_state_id_idx", using: :btree
  add_index "eisai_plan_drug_settings", ["updated_by"], name: "eisai_plan_drug_settings_updated_by_idx", using: :btree

  create_table "eisai_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eisai_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eisai_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "eisai_roles", force: :cascade do |t|
    t.string   "role",                limit: 200
    t.string   "description",         limit: 200
    t.integer  "adminonly",                       default: 0
    t.integer  "requires_approval",               default: 0
    t.integer  "formulary_tables",                default: 0
    t.integer  "analytics",                       default: 0
    t.integer  "active",                          default: 1
    t.boolean  "is_super_user",                   default: false
    t.datetime "created_at",                      default: '2010-07-27 10:57:37'
    t.datetime "updated_at",                      default: '2010-07-27 10:57:37'
    t.boolean  "publisher_reporting",             default: false
  end

  create_table "eisai_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "eisai_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-07-27 10:57:37'
    t.datetime "last_accessed_timestamp",             default: '2010-07-27 10:57:37'
  end

  create_table "eisai_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "emailqueue", force: :cascade do |t|
    t.string   "project",        limit: 50
    t.string   "description",    limit: 100
    t.string   "email",          limit: 60
    t.datetime "emailtimestamp"
    t.boolean  "sent"
  end

  create_table "epocrates_alerts", force: :cascade do |t|
    t.integer  "healthplan_id",                      null: false
    t.integer  "drug_id",                            null: false
    t.integer  "drug_class_id",                      null: false
    t.integer  "provider_id",                        null: false
    t.integer  "formulary_entry_id",                 null: false
    t.integer  "tier_old_id",                        null: false
    t.integer  "tier_new_id",                        null: false
    t.boolean  "prior_auth_old",     default: false
    t.boolean  "prior_auth_new",     default: false
    t.boolean  "quant_limit_old",    default: false
    t.boolean  "quant_limit_new",    default: false
    t.boolean  "step_ther_old",      default: false
    t.boolean  "step_ther_new",      default: false
    t.boolean  "restr_other_old",    default: false
    t.boolean  "restr_other_new",    default: false
    t.integer  "reason_code_old_id",                 null: false
    t.integer  "reason_code_new_id",                 null: false
    t.datetime "alert_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "epocrates_alerts", ["alert_time"], name: "index_epocrates_alerts_on_alert_time", using: :btree

  create_table "epocrates_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2010-04-22 11:42:28'
    t.datetime "updated_at",                              default: '2010-04-22 11:42:28'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "epocrates_formularies", ["drug_class_id"], name: "epocrates_formularies_drug_class_id_idx", using: :btree
  add_index "epocrates_formularies", ["site_user_id"], name: "epocrates_formularies_site_user_id_idx", using: :btree
  add_index "epocrates_formularies", ["state_id"], name: "epocrates_formularies_state_id_idx", using: :btree
  add_index "epocrates_formularies", ["template"], name: "epocrates_formularies_template_idx", using: :btree

  create_table "epocrates_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "epocrates_plan_drug_options", ["created_by"], name: "epocrates_plan_drug_options_created_by_idx", using: :btree
  add_index "epocrates_plan_drug_options", ["updated_by"], name: "epocrates_plan_drug_options_updated_by_idx", using: :btree

  create_table "epocrates_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "epocrates_plan_drug_settings", ["created_by"], name: "epocrates_plan_drug_settings_created_by_idx", using: :btree
  add_index "epocrates_plan_drug_settings", ["drug_id"], name: "epocrates_plan_drug_settings_drug_id_idx", using: :btree
  add_index "epocrates_plan_drug_settings", ["healthplan_id"], name: "epocrates_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "epocrates_plan_drug_settings", ["plan_drug_option_id"], name: "epocrates_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "epocrates_plan_drug_settings", ["state_id"], name: "epocrates_plan_drug_settings_state_id_idx", using: :btree
  add_index "epocrates_plan_drug_settings", ["updated_by"], name: "epocrates_plan_drug_settings_updated_by_idx", using: :btree

  create_table "epocrates_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "epocrates_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.integer  "alerts",                        default: 0
    t.datetime "created_at",                    default: '2010-04-22 11:42:27'
    t.datetime "updated_at",                    default: '2010-04-22 11:42:27'
    t.boolean  "is_super_user",                 default: false
  end

  create_table "epocrates_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "epocrates_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-04-22 11:42:28'
    t.datetime "last_accessed_timestamp",             default: '2010-04-22 11:42:28'
  end

  create_table "epocrates_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "epocratesmedinsight_accounts", force: :cascade do |t|
    t.string   "company_name",  limit: 255
    t.date     "activated_at"
    t.date     "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mi_account_id", limit: 255
  end

  create_table "epocratesmedinsight_analytics_usage_metrics", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.boolean  "is_report_access", default: false
  end

  create_table "epocratesmedinsight_email_domains", force: :cascade do |t|
    t.string   "domain",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "epocratesmedinsight_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.boolean  "is_super_user",                 default: false
    t.datetime "created_at",                    default: '2010-10-20 16:43:52'
    t.datetime "updated_at",                    default: '2010-10-20 16:43:52'
  end

  create_table "epocratesmedinsight_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-10-20 16:43:53'
    t.datetime "last_accessed_timestamp",             default: '2010-10-20 16:43:53'
  end

  create_table "epocratesmedinsight_users", force: :cascade do |t|
    t.string   "login",           limit: 255
    t.string   "email",           limit: 255
    t.string   "password",        limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",      limit: 200
    t.string   "last_name",       limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                      default: 0
    t.integer  "approved",                    default: 0
    t.string   "activationkey",   limit: 50
    t.integer  "site_accountfid"
    t.integer  "account_id"
    t.string   "salt",            limit: 255
    t.datetime "deactivated_at"
  end

  create_table "eurand_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2011-01-17 07:23:04'
    t.datetime "updated_at",                              default: '2011-01-17 07:23:04'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "eurand_formularies", ["drug_class_id"], name: "eurand_formularies_drug_class_id_idx", using: :btree
  add_index "eurand_formularies", ["site_user_id"], name: "eurand_formularies_site_user_id_idx", using: :btree
  add_index "eurand_formularies", ["state_id"], name: "eurand_formularies_state_id_idx", using: :btree
  add_index "eurand_formularies", ["template"], name: "eurand_formularies_template_idx", using: :btree

  create_table "eurand_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "publisher_formulary_name", limit: 255
    t.integer  "publisher_formulary_id"
    t.string   "environment",              limit: 255
    t.string   "file_name",                limit: 255
    t.string   "pdf_unique_id",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eurand_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "eurand_plan_drug_options", ["created_by"], name: "eurand_plan_drug_options_created_by_idx", using: :btree
  add_index "eurand_plan_drug_options", ["updated_by"], name: "eurand_plan_drug_options_updated_by_idx", using: :btree

  create_table "eurand_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "eurand_plan_drug_settings", ["created_by"], name: "eurand_plan_drug_settings_created_by_idx", using: :btree
  add_index "eurand_plan_drug_settings", ["drug_id"], name: "eurand_plan_drug_settings_drug_id_idx", using: :btree
  add_index "eurand_plan_drug_settings", ["healthplan_id"], name: "eurand_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "eurand_plan_drug_settings", ["plan_drug_option_id"], name: "eurand_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "eurand_plan_drug_settings", ["state_id"], name: "eurand_plan_drug_settings_state_id_idx", using: :btree
  add_index "eurand_plan_drug_settings", ["updated_by"], name: "eurand_plan_drug_settings_updated_by_idx", using: :btree

  create_table "eurand_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eurand_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eurand_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "eurand_publisher_formularies", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.string   "current_step",                limit: 255
    t.string   "name",                        limit: 255
    t.string   "competitor_drug_ids",         limit: 255, default: ""
    t.integer  "state_id"
    t.integer  "msa_id"
    t.string   "health_plan_types",           limit: 255, default: ""
    t.string   "commercial_health_plan_ids",  limit: 255, default: ""
    t.string   "medicare_health_plan_ids",    limit: 255, default: ""
    t.string   "medicaid_health_plan_ids",    limit: 255, default: ""
    t.integer  "version"
    t.boolean  "is_active",                               default: true
    t.boolean  "is_published",                            default: false
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "county_id"
    t.string   "geographic_customization",    limit: 255, default: ""
    t.integer  "header_type",                             default: 0
    t.string   "physician_customization",     limit: 255, default: ""
    t.string   "highlighted_health_plan_ids", limit: 255, default: ""
    t.string   "bolded_health_plan_ids",      limit: 255, default: ""
    t.integer  "axcan_id"
    t.datetime "axcan_migrated_at"
  end

  create_table "eurand_publisher_templates", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "klass_name",                limit: 255
    t.string   "spotlight_drug_ids",        limit: 255, default: ""
    t.string   "competitor_drug_ids",       limit: 255, default: ""
    t.integer  "health_plan_count_min"
    t.integer  "health_plan_count_max"
    t.integer  "competitor_drug_count_min"
    t.integer  "competitor_drug_count_max"
    t.string   "allowed_role_ids",          limit: 255, default: ""
    t.boolean  "is_active",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eurand_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.boolean  "is_super_user",                 default: false
    t.datetime "created_at",                    default: '2011-01-17 07:23:04'
    t.datetime "updated_at",                    default: '2011-01-17 07:23:04'
  end

  create_table "eurand_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "eurand_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2011-01-17 07:23:04'
    t.datetime "last_accessed_timestamp",             default: '2011-01-17 07:23:04'
    t.integer  "axcan_id"
    t.datetime "axcan_migrated_at"
  end

  create_table "eurand_users", force: :cascade do |t|
    t.string   "login",             limit: 255
    t.string   "email",             limit: 255
    t.string   "password",          limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",        limit: 200
    t.string   "last_name",         limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                        default: 0
    t.integer  "approved",                      default: 0
    t.string   "activationkey",     limit: 50
    t.integer  "axcan_id"
    t.datetime "axcan_migrated_at"
  end

  create_table "factor", force: :cascade do |t|
    t.boolean "isactive",                    null: false
    t.string  "name",            limit: 255, null: false
    t.string  "codename",        limit: 20,  null: false
    t.text    "explanationtext"
    t.boolean "isriskfactor",                null: false
    t.boolean "ispregnancyrisk",             null: false
  end

  add_index "factor", ["codename"], name: "factor_codename_key", unique: true, using: :btree
  add_index "factor", ["name"], name: "factor_name_key", unique: true, using: :btree

  create_table "feqcriteriaentry", force: :cascade do |t|
    t.integer  "feqfid",                                             null: false
    t.integer  "criteriaentryfid",                                   null: false
    t.integer  "drugclassfid",                                       null: false
    t.text     "notes"
    t.datetime "lastupdate",                                         null: false
    t.integer  "lastupdateffuserid",                                 null: false
    t.integer  "healthplanfid",                                      null: false
    t.string   "restrictionflag",          limit: 5
    t.integer  "reportfid",                                          null: false
    t.text     "restriction_details"
    t.integer  "providerfid"
    t.text     "internal_comments_unused"
    t.boolean  "feqfid_is_updated",                  default: false
  end

  add_index "feqcriteriaentry", ["criteriaentryfid"], name: "feqcriteriaentry_criteriaentry_idx", using: :btree
  add_index "feqcriteriaentry", ["drugclassfid"], name: "feqcriteriaentry_drugclass_idx", using: :btree
  add_index "feqcriteriaentry", ["feqfid"], name: "feqcriteriaentry_feq_idx", using: :btree
  add_index "feqcriteriaentry", ["healthplanfid", "reportfid"], name: "feqcriteriaentry_healthplan_report_idx", using: :btree
  add_index "feqcriteriaentry", ["healthplanfid"], name: "feqcriteriaentry_healthplan_idx", using: :btree
  add_index "feqcriteriaentry", ["lastupdate"], name: "feqcriteriaentry_lastupdate_idx", using: :btree
  add_index "feqcriteriaentry", ["providerfid"], name: "providerfid", using: :btree
  add_index "feqcriteriaentry", ["reportfid", "criteriaentryfid", "feqfid"], name: "feqcriteriaentry_reportfid_criteriaentryfid_feqfid_uniq", unique: true, using: :btree
  add_index "feqcriteriaentry", ["reportfid"], name: "feqcriteriaentry_report_idx", using: :btree

  create_table "ff_access", force: :cascade do |t|
    t.integer  "access",                                    null: false
    t.string   "description", limit: 100,                   null: false
    t.datetime "created",                 default: "now()", null: false
    t.string   "active",                  default: "1",     null: false
  end

  create_table "ff_address", id: :bigserial, force: :cascade do |t|
    t.integer  "addresstypefid",             default: 1,       null: false
    t.string   "address",        limit: 200
    t.string   "city",           limit: 200
    t.integer  "statefid"
    t.integer  "countryfid"
    t.string   "postalcode",     limit: 50
    t.string   "geocode",        limit: 50
    t.datetime "created",                    default: "now()", null: false
    t.integer  "active",                     default: 1,       null: false
  end

  create_table "ff_address_user", id: :bigserial, force: :cascade do |t|
    t.integer "addressfid", null: false
    t.integer "userfid",    null: false
  end

  create_table "ff_addresstype", force: :cascade do |t|
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 255
    t.datetime "created",                 default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "ff_company", id: :bigserial, force: :cascade do |t|
    t.string   "name",         limit: 100,                   null: false
    t.string   "description",  limit: 255
    t.integer  "displayorder"
    t.datetime "created",                  default: "now()", null: false
    t.integer  "active",                   default: 1,       null: false
  end

  create_table "ff_eventlog", id: :bigserial, force: :cascade do |t|
    t.integer  "eventtypefid",                               null: false
    t.string   "description",  limit: 500
    t.integer  "sitefid",                                    null: false
    t.integer  "userfid"
    t.string   "useremail",    limit: 255
    t.string   "pageaction",   limit: 50
    t.string   "ipaddress",    limit: 15
    t.string   "referer",      limit: 255
    t.string   "browser",      limit: 100
    t.string   "path",         limit: 255
    t.string   "query",        limit: 255
    t.string   "attributes",   limit: 255
    t.datetime "created",                  default: "now()", null: false
    t.integer  "active",                   default: 1,       null: false
  end

  create_table "ff_eventtype", force: :cascade do |t|
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 255
    t.datetime "created",                 default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "ff_formulary_batch_status", force: :cascade do |t|
    t.integer  "code",                                      null: false
    t.integer  "active",                  default: 1,       null: false
    t.string   "label",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              default: "now()"
  end

  add_index "ff_formulary_batch_status", ["code"], name: "ff_formulary_batch_status_code_key", unique: true, using: :btree

  create_table "ff_formulary_batch_templates", force: :cascade do |t|
    t.integer "active",                               default: 1,     null: false
    t.integer "site_id",                                              null: false
    t.string  "template",                 limit: 50,                  null: false
    t.string  "template_display_name",    limit: 255
    t.integer "ff_publisher_template_id",                             null: false
    t.boolean "admin_only",                           default: false
    t.string  "role_id_list",             limit: 255, default: ""
  end

  add_index "ff_formulary_batch_templates", ["template"], name: "ff_formulary_batch_templates_template_key", unique: true, using: :btree

  create_table "ff_formulary_batch_tracks", force: :cascade do |t|
    t.integer "ff_formulary_batch_template_id",             null: false
    t.integer "ff_nav_track_id",                            null: false
    t.integer "sequence_index",                             null: false
    t.string  "branch",                         limit: 255
    t.string  "view",                           limit: 255
  end

  create_table "ff_howheard", force: :cascade do |t|
    t.string   "name",         limit: 100,                   null: false
    t.string   "description",  limit: 255
    t.integer  "displayorder"
    t.datetime "created",                  default: "now()", null: false
    t.integer  "active",                   default: 1,       null: false
  end

  create_table "ff_jobtype", force: :cascade do |t|
    t.string   "name",              limit: 100,                   null: false
    t.integer  "usertypefid",                                     null: false
    t.integer  "requireapproval",               default: 0,       null: false
    t.datetime "created",                       default: "now()", null: false
    t.integer  "active",                        default: 1,       null: false
    t.string   "advertisement_tag", limit: 20
  end

  create_table "ff_jobtypepermission", id: :bigserial, force: :cascade do |t|
    t.integer  "jobtypefid",                        null: false
    t.integer  "permissionfid",                     null: false
    t.integer  "permissionvalue",                   null: false
    t.datetime "created",         default: "now()", null: false
    t.integer  "createdby",                         null: false
    t.datetime "modified",                          null: false
    t.integer  "modifiedby",                        null: false
    t.integer  "active",          default: 1,       null: false
  end

  create_table "ff_medicalspecialty", force: :cascade do |t|
    t.string   "name",              limit: 100,                   null: false
    t.string   "description",       limit: 255
    t.integer  "displayorder"
    t.datetime "created",                       default: "now()", null: false
    t.integer  "active",                        default: 1,       null: false
    t.string   "advertisement_tag", limit: 20
  end

  create_table "ff_nav_tracks", force: :cascade do |t|
    t.string "display_name", limit: 255
  end

  create_table "ff_pdf_access_logs", force: :cascade do |t|
    t.integer  "site_id",                                             null: false
    t.integer  "user_id",                                             null: false
    t.string   "formulary_table_name",     limit: 100
    t.integer  "formulary_table_id"
    t.integer  "ff_publisher_template_id"
    t.string   "template",                 limit: 255
    t.string   "pdf_unique_id",            limit: 32
    t.string   "relative_path",            limit: 500
    t.string   "file_name",                limit: 100
    t.string   "environment",              limit: 32
    t.string   "access_method",            limit: 50
    t.string   "http_referer",             limit: 500
    t.boolean  "active",                               default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ff_permission", id: :bigserial, force: :cascade do |t|
    t.string   "name",         limit: 100,                   null: false
    t.string   "shortname",    limit: 15,                    null: false
    t.string   "description",  limit: 255
    t.integer  "displayorder"
    t.datetime "created",                  default: "now()", null: false
    t.integer  "active",                   default: 1,       null: false
  end

  create_table "ff_pharmaceuticalrole", id: :bigserial, force: :cascade do |t|
    t.string   "name",         limit: 100,                   null: false
    t.string   "description",  limit: 255
    t.integer  "displayorder"
    t.datetime "created",                  default: "now()", null: false
    t.integer  "active",                   default: 1,       null: false
  end

  create_table "ff_pharmaemail", force: :cascade do |t|
    t.string   "domain",  limit: 50,                    null: false
    t.string   "company", limit: 100
    t.datetime "created",             default: "now()", null: false
    t.datetime "updated",             default: "now()", null: false
    t.integer  "active",              default: 1,       null: false
  end

  create_table "ff_phone", force: :cascade do |t|
    t.integer  "phonetypefid",            default: 1,       null: false
    t.string   "number",       limit: 50,                   null: false
    t.string   "ext",          limit: 10
    t.datetime "created",                 default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "ff_phone_user", id: :bigserial, force: :cascade do |t|
    t.integer "phonefid", null: false
    t.integer "userfid",  null: false
  end

  create_table "ff_phonetype", force: :cascade do |t|
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 255
    t.datetime "created",                 default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "ff_provider_contact", force: :cascade do |t|
    t.integer  "active",                    default: 1,       null: false
    t.integer  "providerid_fk"
    t.string   "firstname",     limit: 50
    t.string   "lastname",      limit: 50
    t.string   "title",         limit: 100
    t.string   "phone1",        limit: 20
    t.string   "phone2",        limit: 20
    t.string   "phone_mobile",  limit: 20
    t.string   "fax",           limit: 20
    t.string   "email",         limit: 100
    t.string   "address1",      limit: 100
    t.string   "address2",      limit: 100
    t.string   "city",          limit: 50
    t.integer  "state_fk"
    t.string   "zip",           limit: 10
    t.integer  "creatorid_fk"
    t.datetime "create_stamp",              default: "now()"
    t.integer  "modbyid_fk"
    t.datetime "mod_stamp"
  end

  add_index "ff_provider_contact", ["id"], name: "ff_provider_contact_id_idx", using: :btree
  add_index "ff_provider_contact", ["providerid_fk"], name: "ff_provider_contact_providerid_idx", using: :btree
  add_index "ff_provider_contact", ["state_fk"], name: "ff_provider_contact_state_idx", using: :btree

  create_table "ff_provider_contact_notes", force: :cascade do |t|
    t.integer  "contactid_fk"
    t.string   "note",         limit: 65536
    t.integer  "creatorid_fk"
    t.datetime "create_stamp",               default: "now()"
  end

  add_index "ff_provider_contact_notes", ["contactid_fk"], name: "ff_contact_notes_contactid_idx", using: :btree
  add_index "ff_provider_contact_notes", ["create_stamp"], name: "ff_contact_notes_create_stamp_idx", using: :btree
  add_index "ff_provider_contact_notes", ["creatorid_fk"], name: "ff_contact_notes_creatorid_idx", using: :btree

  create_table "ff_publisher_dependent_templates", force: :cascade do |t|
    t.integer "ff_publisher_template_id"
    t.string  "dependent_template",         limit: 50
    t.string  "dependent_template_display", limit: 255
  end

  create_table "ff_publisher_template", force: :cascade do |t|
    t.integer  "active",                                     default: 1
    t.integer  "siteid_fk"
    t.string   "template",                       limit: 50
    t.string   "template_display_name",          limit: 255
    t.string   "spotlight_drugid_list",          limit: 50
    t.string   "competitor_drugid_list",         limit: 255
    t.integer  "drugclass_id"
    t.integer  "min_plan_count"
    t.integer  "max_plan_count"
    t.integer  "max_competitor_drug_count"
    t.string   "commercial_plan_types",          limit: 50
    t.string   "medicare_plan_types",            limit: 50
    t.string   "medicaid_plan_types",            limit: 50
    t.integer  "display_reason_code",                        default: 0
    t.integer  "display_provider",                           default: 0
    t.integer  "min_competitor_drug_count"
    t.string   "template_display_subtitle",      limit: 100
    t.boolean  "spotlight_drug_select",                      default: false
    t.string   "required_competitor_drug_list",  limit: 255
    t.string   "name_code",                      limit: 20
    t.integer  "admin_only",                                 default: 0
    t.integer  "display_copay",                              default: 0
    t.boolean  "cf",                                         default: false, null: false
    t.string   "role_id_list",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "municipal_plan_types",           limit: 255
    t.boolean  "rollup",                                     default: false
    t.integer  "template_amendment_id"
    t.boolean  "is_html_pdf",                                default: true
    t.string   "activation_change_comment",      limit: 255
    t.string   "template_display_group",         limit: 100
    t.integer  "template_display_order"
    t.string   "plan_management_excluded_drugs", limit: 255, default: ""
    t.boolean  "display_preferred_brand_tier",               default: false
    t.string   "pbm_plan_types",                 limit: 255
    t.boolean  "display_formulary_language",                 default: false
    t.integer  "min_hospital_count"
    t.integer  "max_hospital_count"
    t.boolean  "use_national_only",                          default: false
  end

  add_index "ff_publisher_template", ["template"], name: "ff_publisher_template_template_uniq", unique: true, using: :btree

  create_table "ff_publisher_template_backup", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "active"
    t.integer "siteid_fk"
    t.string  "template",                  limit: 50
    t.string  "template_display_name",     limit: 255
    t.string  "spotlight_drugid_list",     limit: 50
    t.string  "competitor_drugid_list",    limit: 255
    t.integer "drugclass_id"
    t.integer "min_plan_count"
    t.integer "max_plan_count"
    t.integer "max_competitor_drug_count"
    t.string  "commercial_plan_types",     limit: 50
    t.string  "medicare_plan_types",       limit: 50
    t.string  "medicaid_plan_types",       limit: 50
    t.integer "display_reason_code"
    t.integer "display_provider"
  end

  create_table "ff_publisher_tracks", force: :cascade do |t|
    t.integer "ff_publisher_template_id"
    t.integer "ff_nav_track_id"
    t.integer "sequence_index"
    t.string  "branch",                   limit: 255
    t.string  "view",                     limit: 255
    t.boolean "view_only",                            default: false
  end

  create_table "ff_resolutioncodes", force: :cascade do |t|
    t.boolean "isactive",             default: true, null: false
    t.string  "code",     limit: 255, default: "",   null: false
  end

  create_table "ff_searchlog", id: :bigserial, force: :cascade do |t|
    t.integer  "sitefid",                                     null: false
    t.integer  "userfid",                                     null: false
    t.integer  "usersessionid",                               null: false
    t.string   "planidlist",    limit: 255
    t.string   "drugidlist",    limit: 255
    t.integer  "drugclassfid"
    t.integer  "statefid"
    t.string   "attributes",    limit: 255
    t.datetime "created",                   default: "now()", null: false
    t.integer  "active",                    default: 1,       null: false
  end

  add_index "ff_searchlog", ["userfid"], name: "ff_searchlog_userfid_idx", using: :btree

  create_table "ff_setting", id: :bigserial, force: :cascade do |t|
    t.integer  "sitefid",                 default: 1,       null: false
    t.string   "scope",       limit: 20
    t.string   "name",        limit: 100,                   null: false
    t.string   "value",       limit: 500,                   null: false
    t.string   "description", limit: 255
    t.datetime "created",                 default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "ff_site", force: :cascade do |t|
    t.string   "name",                       limit: 100,                   null: false
    t.string   "title",                      limit: 255,                   null: false
    t.string   "url",                        limit: 100,                   null: false
    t.string   "description",                limit: 255
    t.datetime "created",                                default: "now()", null: false
    t.integer  "active",                                 default: 1,       null: false
    t.string   "usertable",                  limit: 50
    t.string   "disclaimer",                 limit: 250
    t.string   "prefix_code",                limit: 30
    t.boolean  "module_publisher",                       default: false
    t.string   "rx_data_source",             limit: 3
    t.string   "rx_data_dsn",                limit: 10
    t.string   "rx_trend_start",             limit: 7
    t.boolean  "rails",                                  default: false
    t.string   "rx_id_key",                  limit: 10
    t.integer  "session_expiration_minutes",             default: 60
    t.integer  "password_lifetime"
    t.string   "internal_url",               limit: 255, default: ""
  end

  add_index "ff_site", ["prefix_code"], name: "ff_site_prefix_code_key", unique: true, using: :btree

  create_table "ff_site_analytics_reports", force: :cascade do |t|
    t.integer  "sitefid",                                        null: false
    t.integer  "reportfid",                                      null: false
    t.integer  "test_mode",                        default: 0
    t.integer  "isactive",                         default: 1
    t.string   "restricted_user_roles", limit: 25, default: "0"
    t.datetime "created_on"
    t.integer  "created_by"
    t.datetime "updated_on"
    t.integer  "updated_by"
  end

  create_table "ff_site_drugclass", id: :bigserial, force: :cascade do |t|
    t.integer  "drugclassfid",                                       null: false
    t.integer  "sitefid",                                            null: false
    t.integer  "viewtable",          default: 0,                     null: false
    t.integer  "publisher",          default: 0,                     null: false
    t.integer  "analytics",          default: 0,                     null: false
    t.integer  "rxanalytics",        default: 0,                     null: false
    t.integer  "active",             default: 1,                     null: false
    t.datetime "analytics_inactive", default: '2035-12-31 23:59:59', null: false
    t.integer  "spotlight_drug"
    t.integer  "ordering",           default: 0
    t.integer  "accounts",           default: 0,                     null: false
    t.integer  "copay",              default: 0,                     null: false
    t.integer  "alerts",             default: 0
    t.datetime "created_on"
    t.integer  "created_by"
    t.datetime "updated_on"
    t.integer  "updated_by"
  end

  create_table "ff_site_healthplan", force: :cascade do |t|
    t.integer  "ff_sitefid",                                  null: false
    t.integer  "healthplanfid",                               null: false
    t.string   "planname",      limit: 255,                   null: false
    t.datetime "modified",                  default: "now()", null: false
    t.integer  "active",                    default: 1,       null: false
  end

  add_index "ff_site_healthplan", ["ff_sitefid", "healthplanfid"], name: "ff_sitefid_healthplanfid_idx", using: :btree
  add_index "ff_site_healthplan", ["healthplanfid"], name: "healthplanfid_idx", using: :btree

  create_table "ff_status", force: :cascade do |t|
    t.integer  "status",                                    null: false
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 255
    t.datetime "created",                 default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "ff_template_amendments", force: :cascade do |t|
    t.integer  "ff_publisher_template_id"
    t.string   "value",                    limit: 255
    t.string   "field",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publisher_template_id"
  end

  create_table "ff_template_change_logs", force: :cascade do |t|
    t.string   "template_name",            limit: 255
    t.string   "username",                 limit: 255
    t.integer  "site_user_id"
    t.integer  "ff_publisher_template_id"
    t.string   "change_type",              limit: 255
    t.integer  "site_id"
    t.text     "change_list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publisher_template_id"
  end

  create_table "ff_tickets", force: :cascade do |t|
    t.integer  "creator_id",                                    null: false
    t.datetime "created_at",                                    null: false
    t.string   "firstname",            limit: 200,              null: false
    t.string   "lastname",             limit: 200,              null: false
    t.string   "email",                limit: 200,              null: false
    t.datetime "emailed_at",                                    null: false
    t.string   "telephone_number",     limit: 200
    t.text     "message",                                       null: false
    t.text     "ff_response"
    t.string   "status",               limit: 32
    t.integer  "ff_resolutioncode_id"
    t.integer  "updater_id"
    t.datetime "updated_at"
    t.integer  "assignedto_id",                    default: 0
    t.string   "company",              limit: 100, default: ""
  end

  create_table "ff_user", id: :bigserial, force: :cascade do |t|
    t.string   "email",                 limit: 255,                   null: false
    t.string   "password",              limit: 255,                   null: false
    t.datetime "passwordtimestamp",                 default: "now()", null: false
    t.string   "salutation",            limit: 10
    t.string   "firstname",             limit: 255,                   null: false
    t.string   "lastname",              limit: 255,                   null: false
    t.integer  "jobtypefid",                                          null: false
    t.string   "jobtypeother",          limit: 100
    t.integer  "medicalspecialtyfid"
    t.integer  "companyfid"
    t.string   "companyother",          limit: 100
    t.integer  "pharmaceuticalrolefid"
    t.integer  "howheardfid"
    t.string   "howheardother",         limit: 100
    t.string   "licensenumber",         limit: 100
    t.string   "licensestate",          limit: 2
    t.string   "licensedea",            limit: 100
    t.integer  "optin",                             default: 0,       null: false
    t.integer  "status",                            default: 0,       null: false
    t.integer  "access",                            default: 0,       null: false
    t.datetime "created",                           default: "now()", null: false
    t.integer  "createdby",                                           null: false
    t.datetime "modified",                                            null: false
    t.integer  "modifiedby",                                          null: false
    t.integer  "legacyfid"
    t.integer  "active",                            default: 1,       null: false
  end

  create_table "ff_user_download", force: :cascade do |t|
    t.integer  "ff_userfid",                  null: false
    t.string   "type",            limit: 10,  null: false
    t.string   "version",         limit: 10,  null: false
    t.datetime "lastupdate",                  null: false
    t.string   "user_ip",         limit: 20
    t.string   "http_user_agent", limit: 200
    t.string   "http_host",       limit: 100
  end

  create_table "ff_user_download_type", force: :cascade do |t|
    t.string "name",           limit: 10,  null: false
    t.string "description",    limit: 100
    t.string "currentversion", limit: 10
  end

  create_table "ff_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.datetime "login_timestamp",                     default: "now()"
    t.datetime "last_accessed_timestamp",             default: "now()"
  end

  create_table "ff_userdrug", force: :cascade do |t|
    t.integer "userfid", null: false
    t.integer "drugfid", null: false
  end

  add_index "ff_userdrug", ["drugfid"], name: "ff_userdrug_drugfid_idx", using: :btree
  add_index "ff_userdrug", ["userfid"], name: "ff_userdrug_userfid_idx", using: :btree

  create_table "ff_userhealthplan", force: :cascade do |t|
    t.integer "userfid",       null: false
    t.integer "healthplanfid", null: false
    t.integer "statefid",      null: false
  end

  add_index "ff_userhealthplan", ["healthplanfid"], name: "ff_userhealthplan_healthplanfid_idx", using: :btree
  add_index "ff_userhealthplan", ["userfid"], name: "ff_userhealthplan_userfid_idx", using: :btree

  create_table "ff_usersession", id: :bigserial, force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.string   "sessionid",             limit: 200, null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                    null: false
    t.datetime "lastaccessedtimestamp",             null: false
    t.integer  "legacyfid"
  end

  create_table "ff_usertype", force: :cascade do |t|
    t.string   "name",    limit: 100,                   null: false
    t.datetime "created",             default: "now()", null: false
    t.string   "active",              default: "1",     null: false
  end

  create_table "ff_view_formulary_templates", force: :cascade do |t|
    t.datetime "created_at",                        default: '2009-05-07 12:46:13'
    t.datetime "updated_at",                        default: '2009-05-07 12:46:13'
    t.integer  "site_id"
    t.integer  "active"
    t.string   "template",              limit: 255,                                 null: false
    t.string   "template_display_name", limit: 255
    t.integer  "display_reason_code"
  end

  add_index "ff_view_formulary_templates", ["site_id"], name: "ff_view_formulary_templates_site_id_idx", using: :btree

  create_table "ff_view_formulary_tracks", force: :cascade do |t|
    t.datetime "created_at",                                default: '2009-05-07 12:46:13'
    t.datetime "updated_at",                                default: '2009-05-07 12:46:13'
    t.integer  "ff_view_formulary_template_id"
    t.integer  "ff_nav_track_id"
    t.integer  "sequence_index"
    t.string   "branch",                        limit: 255
    t.string   "view",                          limit: 255
  end

  add_index "ff_view_formulary_tracks", ["ff_nav_track_id"], name: "ff_view_formulary_tracks_ff_nav_track_id_idx", using: :btree
  add_index "ff_view_formulary_tracks", ["ff_view_formulary_template_id"], name: "ff_view_formulary_tracks_ff_view_formulary_template_id_idx", using: :btree

  create_table "ffdruglist", force: :cascade do |t|
    t.integer  "ffdruglisttypefid",               null: false
    t.integer  "drugfid",                         null: false
    t.string   "comments",           limit: 1000
    t.datetime "lastupdate",                      null: false
    t.integer  "lastupdateffuserid",              null: false
    t.datetime "createddate",                     null: false
    t.integer  "createdffuserid",                 null: false
  end

  add_index "ffdruglist", ["drugfid"], name: "ffdruglist_drugfid", using: :btree

  create_table "ffdruglisttype", force: :cascade do |t|
    t.string   "name",                limit: 25,                    null: false
    t.string   "description",         limit: 100,                   null: false
    t.boolean  "internal_list",                   default: false
    t.datetime "lastupdate",                      default: "now()"
    t.integer  "lastupdateffuserfid"
  end

  create_table "ffpbmformularymonitor", force: :cascade do |t|
    t.integer "drugclassfid", null: false
  end

  create_table "ffrole", force: :cascade do |t|
    t.string  "role",        limit: 255, null: false
    t.string  "description", limit: 255
    t.boolean "isactive",                null: false
    t.integer "orderindex"
  end

  add_index "ffrole", ["role"], name: "ffrole_role_key", unique: true, using: :btree

  create_table "ffuser", primary_key: "userid", force: :cascade do |t|
    t.string   "first",       limit: 50
    t.string   "mi",          limit: 50
    t.string   "last",        limit: 50
    t.string   "email",       limit: 50
    t.string   "password",    limit: 50
    t.integer  "loginid",                default: 0
    t.string   "perm",        limit: 50
    t.string   "role",        limit: 50
    t.string   "fname",       limit: 50
    t.datetime "dc",                     default: "now()"
    t.datetime "dlm"
    t.string   "im",          limit: 50
    t.string   "address1",    limit: 50
    t.string   "address2",    limit: 50
    t.string   "city",        limit: 50
    t.string   "state",       limit: 50
    t.string   "zip",         limit: 50
    t.string   "phone",       limit: 50
    t.string   "fax",         limit: 50
    t.string   "mobile",      limit: 50
    t.string   "pager",       limit: 50
    t.string   "addresstype", limit: 50
    t.string   "vpassword",   limit: 10
    t.string   "zip2",        limit: 10
    t.string   "country",     limit: 50
    t.string   "title",       limit: 10
    t.string   "datec",       limit: 50
    t.string   "datem",       limit: 50
    t.string   "lastmodby",   limit: 50
    t.string   "lastmodbyid", limit: 5
    t.boolean  "is_active"
  end

  create_table "ffuserrole", force: :cascade do |t|
    t.integer "ffuserfid", null: false
    t.integer "ffrolefid", null: false
  end

  add_index "ffuserrole", ["ffuserfid", "ffrolefid"], name: "ffuserrole_ffuserfid_key", unique: true, using: :btree

  create_table "filter_restrictions_restriction_criteria_filters", force: :cascade do |t|
    t.integer  "user_id",                           null: false
    t.integer  "site_id",                           null: false
    t.string   "filter_state",         limit: 100
    t.integer  "report_id"
    t.integer  "geography_id"
    t.string   "state_ids",            limit: 1000
    t.string   "health_plan_type_ids", limit: 1000
    t.string   "drug_ids",             limit: 1000
    t.string   "criteria_display",     limit: 100
    t.string   "criteria_ids",         limit: 1000
    t.string   "string",               limit: 100
    t.string   "criteria_group_ids",   limit: 1000
    t.string   "msa_ids",              limit: 1000
    t.string   "county_ids",           limit: 2000
    t.string   "display_by",           limit: 100
    t.string   "zip_code",             limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "criteria_ranges"
    t.text     "health_plan_ids"
  end

  create_table "fingertipformulary", primary_key: "entityid", force: :cascade do |t|
    t.string   "commercialplanordered", limit: 500
    t.string   "competitor_druglist",   limit: 500
    t.integer  "copay_option",                      default: 0,       null: false
    t.string   "description",           limit: 100
    t.string   "doctorname",            limit: 100
    t.integer  "drugclassfid",                                        null: false
    t.string   "druglist",              limit: 500,                   null: false
    t.string   "geo_area_name",         limit: 255
    t.integer  "header_option"
    t.integer  "isactive",                          default: 1,       null: false
    t.integer  "isexported",                        default: 0,       null: false
    t.integer  "ispublished",                       default: 0,       null: false
    t.string   "mark_new_list",         limit: 500
    t.string   "medicaidplanordered",   limit: 500
    t.string   "medicareplanordered",   limit: 500
    t.string   "planboldedlist",        limit: 500
    t.string   "planlist",              limit: 500
    t.string   "plantypeorder",         limit: 50
    t.string   "repname",               limit: 100
    t.integer  "spotlightdrugfid",                                    null: false
    t.integer  "statefid",                                            null: false
    t.string   "tableversion",          limit: 100,                   null: false
    t.string   "template",              limit: 50
    t.integer  "userfid"
    t.integer  "versionnumber",                     default: 0,       null: false
    t.datetime "createtimestamp",                   default: "now()", null: false
    t.datetime "exporttimestamp"
    t.datetime "modifytimestamp"
    t.datetime "publishtimestamp"
  end

  add_index "fingertipformulary", ["drugclassfid"], name: "fingertipformulary_drugclassfid_idx", using: :btree
  add_index "fingertipformulary", ["spotlightdrugfid"], name: "fingertipformulary_spotlightdrugfid_idx", using: :btree
  add_index "fingertipformulary", ["statefid"], name: "fingertipformulary_statefid_idx", using: :btree
  add_index "fingertipformulary", ["userfid"], name: "fingertipformulary_userfid_idx", using: :btree

  create_table "formulary", force: :cascade do |t|
    t.boolean  "isactive",                                null: false
    t.integer  "defaultbrandtierfid"
    t.integer  "defaultgenerictierfid"
    t.integer  "updatefrequencymonths"
    t.datetime "lastupdate"
    t.integer  "lastupdateffuserfid"
    t.boolean  "ppdapplies",              default: false, null: false
    t.integer  "publishuserfid"
    t.datetime "createtimestamp"
    t.datetime "modifytimestamp"
    t.integer  "t3_preferred",            default: 0
    t.integer  "preferred_brand_tier_id"
  end

  create_table "formulary_assignment_attachment_files", force: :cascade do |t|
    t.integer "formulary_assignment_id", null: false
    t.integer "attachment_file_id",      null: false
  end

  create_table "formulary_assignments", force: :cascade do |t|
    t.integer  "health_plan_id",                                    null: false
    t.integer  "health_plan_display_id",                            null: false
    t.string   "update_type",               limit: 255,             null: false
    t.string   "formulary_format",          limit: 255,             null: false
    t.text     "comments"
    t.integer  "formulary_assigned_to_id",                          null: false
    t.integer  "validation_assigned_to_id"
    t.datetime "formulary_assigned_at"
    t.datetime "formulary_completed_at"
    t.datetime "validation_assigned_at"
    t.datetime "validation_completed_at"
    t.integer  "formulary_hours"
    t.integer  "formulary_minutes"
    t.decimal  "formulary_time"
    t.integer  "validation_hours"
    t.integer  "validation_minutes"
    t.decimal  "validation_time"
    t.integer  "status",                                default: 1, null: false
    t.datetime "formulary_paid_at"
    t.datetime "validation_paid_at"
    t.datetime "assignment_finished_at"
  end

  create_table "formulary_comments", force: :cascade do |t|
    t.integer  "user_id",                                 null: false
    t.integer  "health_plan_id"
    t.string   "comment",        limit: 5000,             null: false
    t.datetime "created_on",                              null: false
    t.datetime "updated_on"
    t.integer  "active",                      default: 1, null: false
  end

  create_table "formulary_copy_queue", force: :cascade do |t|
    t.integer  "source_health_plan_display_id",                             null: false
    t.integer  "copy_health_plan_display_id",                               null: false
    t.string   "copy_restrictions_list",        limit: 7
    t.datetime "created_at",                              default: "now()", null: false
    t.integer  "created_by",                                                null: false
    t.boolean  "is_copy_completed",                       default: false
    t.datetime "copy_completed_at"
    t.boolean  "was_copy_auto_published",                 default: false
    t.boolean  "is_copy_published",                       default: false
  end

  create_table "formulary_documents", force: :cascade do |t|
    t.string   "file_name",      limit: 200, null: false
    t.integer  "file_size",                  null: false
    t.integer  "user_id",                    null: false
    t.integer  "health_plan_id"
    t.datetime "upload_date",                null: false
  end

  create_table "formulary_drug_comments", force: :cascade do |t|
    t.integer  "health_plan_id",              null: false
    t.integer  "drug_id",                     null: false
    t.string   "comment_text",    limit: 250, null: false
    t.datetime "last_updated",                null: false
    t.integer  "last_updated_by",             null: false
  end

  create_table "formulary_garbage", id: false, force: :cascade do |t|
    t.integer  "id"
    t.boolean  "isactive"
    t.integer  "defaultbrandtierfid"
    t.integer  "defaultgenerictierfid"
    t.integer  "updatefrequencymonths"
    t.datetime "lastupdate"
    t.integer  "lastupdateffuserfid"
    t.boolean  "ppdapplies"
    t.integer  "publishuserfid"
  end

  create_table "formulary_update_action_events", id: false, force: :cascade do |t|
    t.integer  "health_plan_id",                                         null: false
    t.integer  "formulary_id",                                           null: false
    t.integer  "formulary_update_action_id",                             null: false
    t.integer  "copy_source_health_plan_id"
    t.string   "copy_restrictions_list",     limit: 7
    t.datetime "created_at",                           default: "now()", null: false
    t.integer  "created_by",                                             null: false
    t.integer  "reset_tier_id"
    t.integer  "reset_restriction_id"
    t.datetime "formulary_update_date"
  end

  create_table "formulary_update_actions", force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "formularyarchive", force: :cascade do |t|
    t.integer  "healthplanfid",         null: false
    t.boolean  "isactive"
    t.integer  "defaultbrandtierfid"
    t.integer  "defaultgenerictierfid"
    t.integer  "updatefrequencymonths"
    t.datetime "lastupdate"
  end

  add_index "formularyarchive", ["healthplanfid"], name: "formularyarchive_healthplanfid_idx", using: :btree

  create_table "formularyarchive_backup", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "healthplanfid"
    t.boolean  "isactive"
    t.integer  "defaultbrandtierfid"
    t.integer  "defaultgenerictierfid"
    t.integer  "updatefrequencymonths"
    t.datetime "lastupdate"
  end

  create_table "formularyentry", force: :cascade do |t|
    t.integer  "formularyfid",                                     null: false
    t.integer  "drugfid",                                          null: false
    t.integer  "tierfid",                                          null: false
    t.boolean  "isresetmode",                                      null: false
    t.integer  "legacyfid"
    t.integer  "reasoncodefid",                    default: 0,     null: false
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.boolean  "specialty_copay",                  default: false, null: false
    t.boolean  "preferred"
    t.string   "restriction_comments", limit: 256
  end

  add_index "formularyentry", ["drugfid"], name: "formularyentry_drugfid_idx", using: :btree
  add_index "formularyentry", ["formularyfid", "drugfid"], name: "formularyentry_formularyfid_key", unique: true, using: :btree
  add_index "formularyentry", ["formularyfid"], name: "formularyentry_formularyfid_idx", using: :btree
  add_index "formularyentry", ["reasoncodefid"], name: "formularyentry_reasoncodefid_idx", using: :btree
  add_index "formularyentry", ["tierfid"], name: "formularyentry_tierfid_idx", using: :btree

  create_table "formularyentry_archives", force: :cascade do |t|
    t.integer  "health_plan_id",                   null: false
    t.integer  "drug_id",                          null: false
    t.integer  "new_tier_id",                      null: false
    t.integer  "new_reason_code_id",               null: false
    t.boolean  "new_pa_value",                     null: false
    t.boolean  "new_ql_value",                     null: false
    t.boolean  "new_st_value",                     null: false
    t.boolean  "new_or_value",                     null: false
    t.integer  "old_tier_id",                      null: false
    t.integer  "old_reason_code_id",               null: false
    t.boolean  "old_pa_value",                     null: false
    t.boolean  "old_ql_value",                     null: false
    t.boolean  "old_st_value",                     null: false
    t.boolean  "old_or_value",                     null: false
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.datetime "published_at"
    t.integer  "published_by"
    t.boolean  "preferred"
    t.boolean  "new_preferred_value"
    t.boolean  "old_preferred_value"
    t.string   "restriction_comments", limit: 256
  end

  add_index "formularyentry_archives", ["drug_id"], name: "formularyentry_archive_drug_idx", using: :btree
  add_index "formularyentry_archives", ["health_plan_id"], name: "formularyentry_archive_health_plan_idx", using: :btree

  create_table "formularyentry_minocin_backup_20111026", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "formularyfid"
    t.integer  "drugfid"
    t.integer  "tierfid"
    t.boolean  "isresetmode"
    t.integer  "legacyfid"
    t.integer  "reasoncodefid"
    t.datetime "updated_at"
    t.integer  "updated_by"
  end

  create_table "formularyentryarchive", force: :cascade do |t|
    t.integer "formularyfid",  null: false
    t.integer "healthplanfid", null: false
    t.integer "drugfid",       null: false
    t.integer "tierfid",       null: false
    t.integer "reasoncodefid"
  end

  add_index "formularyentryarchive", ["formularyfid"], name: "formularyentryarchive_formularyfid_idx", using: :btree
  add_index "formularyentryarchive", ["healthplanfid"], name: "formularyentryarchive_healthplanfid_idx", using: :btree

  create_table "formularyentryarchive_backup", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "formularyfid"
    t.integer "healthplanfid"
    t.integer "drugfid"
    t.integer "tierfid"
    t.integer "reasoncodefid"
  end

  create_table "formularyentryqualifier", force: :cascade do |t|
    t.integer  "formularyentryfid", null: false
    t.integer  "qualifierfid",      null: false
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.integer  "legacyfid"
  end

  add_index "formularyentryqualifier", ["formularyentryfid", "qualifierfid"], name: "formularyentryqualifier_formularyentryfid_key", unique: true, using: :btree
  add_index "formularyentryqualifier", ["formularyentryfid"], name: "formularyentryqualifier_formularyentryfid_idx", using: :btree
  add_index "formularyentryqualifier", ["legacyfid"], name: "formularyentryqualifier_legacyfid_idx", unique: true, using: :btree
  add_index "formularyentryqualifier", ["qualifierfid"], name: "formularyentryqualifier_qualifierfid_idx", using: :btree

  create_table "formularyentryqualifier_minocin_backup_20111026", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "formularyentryfid"
    t.integer  "qualifierfid"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.integer  "legacyfid"
  end

  create_table "formularyentryqualifierarchive", force: :cascade do |t|
    t.integer "formularyfid",      null: false
    t.integer "formularyentryfid", null: false
    t.integer "healthplanfid",     null: false
    t.integer "qualifierfid",      null: false
  end

  add_index "formularyentryqualifierarchive", ["formularyentryfid"], name: "formularyentryqualifierarchive_formularyentryfid_idx", using: :btree
  add_index "formularyentryqualifierarchive", ["formularyfid"], name: "formularyentryqualifierarchive_formularyfid_idx", using: :btree
  add_index "formularyentryqualifierarchive", ["healthplanfid"], name: "formularyentryqualifierarchive_healthplanfid_idx", using: :btree

  create_table "formularyentryqualifierarchive_backup", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "formularyfid"
    t.integer "formularyentryfid"
    t.integer "healthplanfid"
    t.integer "qualifierfid"
  end

  create_table "formularyentryupdates", force: :cascade do |t|
    t.integer  "healthplanfid"
    t.integer  "drugfid"
    t.integer  "formularyentryfid",                                null: false
    t.integer  "tierfid",                          default: 8
    t.boolean  "priorauth",                        default: false, null: false
    t.boolean  "quantlimit",                       default: false, null: false
    t.boolean  "stepther",                         default: false, null: false
    t.datetime "createtimestamp",                                  null: false
    t.integer  "oldtierfid",                       default: 8
    t.boolean  "oldpriorauth",                     default: false
    t.boolean  "oldquantlimit",                    default: false
    t.boolean  "oldstepther",                      default: false
    t.datetime "modifytimestamp"
    t.datetime "activedate",                                       null: false
    t.integer  "reasoncodefid",                    default: 0,     null: false
    t.boolean  "isupdated",                        default: false, null: false
    t.boolean  "restrother",                       default: false, null: false
    t.boolean  "oldrestrother",                    default: false
    t.integer  "oldreasoncodefid",                 default: 0
    t.integer  "iscopy",                           default: 0,     null: false
    t.integer  "isreviewed",                       default: 0,     null: false
    t.integer  "indexfid"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.boolean  "specialty_copay",                  default: false, null: false
    t.boolean  "old_specialty_copay",              default: false, null: false
    t.boolean  "preferred"
    t.string   "restriction_comments", limit: 256
  end

  add_index "formularyentryupdates", ["drugfid"], name: "formularyentryupdates_drugfid_idx", using: :btree
  add_index "formularyentryupdates", ["formularyentryfid"], name: "formularyentryupdates_formularyentryfid_idx", using: :btree
  add_index "formularyentryupdates", ["healthplanfid"], name: "formularyentryupdates_healthplanfid_idx", using: :btree
  add_index "formularyentryupdates", ["oldtierfid"], name: "formularyentryupdates_oldtierfid_idx", using: :btree
  add_index "formularyentryupdates", ["tierfid"], name: "formularyentryupdates_tierfid_idx", using: :btree

  create_table "formularynavigation", force: :cascade do |t|
    t.integer "ff_sitefid",                                 null: false
    t.boolean "medicare",                                   null: false
    t.integer "arraypageid",                                null: false
    t.boolean "batch",                                      null: false
    t.string  "pagename",         limit: 50,                null: false
    t.string  "elementlabel",     limit: 50,                null: false
    t.string  "elementtarget",    limit: 50,                null: false
    t.boolean "elementhyperlink",            default: true
  end

  create_table "formularyorder", force: :cascade do |t|
    t.integer "dsiuserfid",                 null: false
    t.integer "drugfid",                    null: false
    t.integer "type",                       null: false
    t.integer "quantitydefault"
    t.integer "quantitycurrent"
    t.string  "territoryfid",    limit: 15, null: false
  end

  add_index "formularyorder", ["drugfid"], name: "formularyorder_drugfid_idx", using: :btree
  add_index "formularyorder", ["dsiuserfid"], name: "formularyorder_dsiuserfid_idx", using: :btree
  add_index "formularyorder", ["territoryfid"], name: "formularyorder_territoryfid_idx", using: :btree

  create_table "formularyorder_default", force: :cascade do |t|
    t.integer "typeid",       null: false
    t.integer "drugfid",      null: false
    t.integer "defaultvalue", null: false
  end

  create_table "formularyorder_history", force: :cascade do |t|
    t.integer  "formularyorderfid",             null: false
    t.datetime "lastupdate",                    null: false
    t.string   "description",       limit: 255
    t.integer  "quantity"
    t.integer  "balance"
    t.string   "template",          limit: 50
    t.integer  "dsiuserfid",                    null: false
    t.string   "territoryfid",      limit: 15,  null: false
  end

  add_index "formularyorder_history", ["dsiuserfid"], name: "formularyorder_history_dsiuserfid_idx", using: :btree
  add_index "formularyorder_history", ["territoryfid"], name: "formularyorder_history_territoryfid_idx", using: :btree

  create_table "formularyschedule", force: :cascade do |t|
    t.integer  "providerfid",                                           null: false
    t.integer  "formularyfid",                                          null: false
    t.integer  "schedulefrequencyfid",                                  null: false
    t.string   "schedulefrequencycomments",     limit: 500
    t.integer  "schedulefrequencynextfid",                              null: false
    t.string   "schedulefrequencynextcomments", limit: 500
    t.text     "notes"
    t.datetime "created",                                               null: false
    t.datetime "modified",                                              null: false
    t.string   "modifiedby",                    limit: 100
    t.integer  "active",                                    default: 1, null: false
  end

  create_table "formularyschedulefrequency", force: :cascade do |t|
    t.string  "schedulefrequency", limit: 20,              null: false
    t.string  "description",       limit: 100
    t.integer "active",                        default: 1, null: false
  end

  create_table "formularyupdatearchive", force: :cascade do |t|
    t.integer  "healthplanfid",     null: false
    t.integer  "formularyfid",      null: false
    t.datetime "archivedate",       null: false
    t.datetime "formularycreated"
    t.datetime "formularymodified"
    t.integer  "publishuserfid"
  end

  create_table "galderma_plan_exclusion", force: :cascade do |t|
    t.integer  "healthplan_id",                    null: false
    t.boolean  "isactive"
    t.boolean  "exclude_table"
    t.datetime "created_at",     default: "now()", null: false
    t.integer  "create_user_id"
    t.datetime "updated_at"
    t.integer  "update_user_id"
  end

  add_index "galderma_plan_exclusion", ["create_user_id"], name: "galderma_plan_exclusion_create_user_id", using: :btree
  add_index "galderma_plan_exclusion", ["healthplan_id"], name: "galderma_plan_exclusion_healthplan_id", using: :btree
  add_index "galderma_plan_exclusion", ["healthplan_id"], name: "galderma_plan_exclusion_healthplan_id_key", unique: true, using: :btree
  add_index "galderma_plan_exclusion", ["healthplan_id"], name: "healthplan_id_uniq", unique: true, using: :btree
  add_index "galderma_plan_exclusion", ["update_user_id"], name: "galderma_plan_exclusion_update_user_id", using: :btree

  create_table "galdermaformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                          null: false
    t.integer  "statefid"
    t.integer  "drugclassfid",                                     null: false
    t.string   "planlist",                                         null: false
    t.string   "druglist",                                         null: false
    t.string   "tableversion",             limit: 100,             null: false
    t.integer  "versionnumber",                        default: 0, null: false
    t.integer  "ispublished",                          default: 0, null: false
    t.integer  "isexported",                           default: 0, null: false
    t.integer  "isactive",                             default: 1, null: false
    t.datetime "createtimestamp",                                  null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "modifytimestamp",                                  null: false
    t.integer  "mostrecent",                           default: 0, null: false
    t.string   "planorderedlist",          limit: 500
    t.string   "planboldedlist",           limit: 500
    t.string   "description",              limit: 100
    t.string   "doctorname",               limit: 100
    t.integer  "tabletype",                            default: 1, null: false
    t.string   "template",                 limit: 50
    t.string   "repname",                  limit: 100
    t.string   "plan_type_category_order", limit: 50
    t.integer  "header_option"
    t.string   "mark_new_list",            limit: 500
    t.string   "geo_area_name",            limit: 255
  end

  add_index "galdermaformulary", ["drugclassfid"], name: "galdermaformulary_drugclassid_idx", using: :btree
  add_index "galdermaformulary", ["statefid"], name: "galdermaformulary_stateid_idx", using: :btree
  add_index "galdermaformulary", ["userfid"], name: "galdermaformulary_userid_idx", using: :btree

  create_table "galdermarole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "galdermauser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "galdermauser", ["email"], name: "galdermauser_email_key", unique: true, using: :btree

  create_table "galdermauseralert", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.datetime "archived_at"
  end

  create_table "galdermauserservice", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid",      null: false
    t.integer "drugclassfid"
  end

  create_table "galdermausersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "genentech_publisher_activity_report_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genentech_publisher_activity_report_states", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genentech_publisher_activity_report_templates", force: :cascade do |t|
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "template_id"
    t.string   "template_type",                limit: 255
  end

  create_table "genentech_publisher_activity_reports", force: :cascade do |t|
    t.boolean  "use_preset_date"
    t.string   "preset_date",     limit: 255
    t.date     "end_date"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genentechdataexport", force: :cascade do |t|
    t.integer  "healthplanfid",                   null: false
    t.datetime "modified",      default: "now()", null: false
    t.integer  "active",        default: 1,       null: false
  end

  create_table "genentechformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                   null: false
    t.integer  "statefid",                                  null: false
    t.integer  "drugclassfid",                              null: false
    t.string   "planlist",         limit: 1000,             null: false
    t.string   "druglist",         limit: 100,              null: false
    t.string   "description",      limit: 100,              null: false
    t.string   "tableversion",     limit: 100,              null: false
    t.integer  "versionnumber",                 default: 0, null: false
    t.integer  "ispublished",                   default: 0, null: false
    t.integer  "isexported",                    default: 0, null: false
    t.integer  "isactive",                      default: 1, null: false
    t.integer  "mostrecent",                    default: 0, null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "createtimestamp",                           null: false
    t.datetime "modifytimestamp",                           null: false
    t.text     "extratext"
    t.integer  "msafid",                        default: 0
  end

  create_table "genentechmsa", force: :cascade do |t|
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 100
    t.datetime "modified",                default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "genentechmsastate", force: :cascade do |t|
    t.integer  "msafid",                     null: false
    t.integer  "statefid",                   null: false
    t.datetime "modified", default: "now()", null: false
    t.integer  "active",   default: 1,       null: false
  end

  create_table "genentechrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.integer  "manageuser",                   default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
    t.integer  "admindataexport",              default: 0, null: false
  end

  create_table "genentechuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "genentechuser", ["email"], name: "genentechuser_email_key", unique: true, using: :btree

  create_table "genentechusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "genericdrugalert", force: :cascade do |t|
    t.integer  "drugfid"
    t.datetime "createtimestamp", null: false
    t.integer  "legacyfid"
  end

  create_table "gilead_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2010-05-11 12:50:00'
    t.datetime "updated_at",                              default: '2010-05-11 12:50:00'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "gilead_formularies", ["drug_class_id"], name: "gilead_formularies_drug_class_id_idx", using: :btree
  add_index "gilead_formularies", ["site_user_id"], name: "gilead_formularies_site_user_id_idx", using: :btree
  add_index "gilead_formularies", ["state_id"], name: "gilead_formularies_state_id_idx", using: :btree
  add_index "gilead_formularies", ["template"], name: "gilead_formularies_template_idx", using: :btree

  create_table "gilead_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "gilead_plan_drug_options", ["created_by"], name: "gilead_plan_drug_options_created_by_idx", using: :btree
  add_index "gilead_plan_drug_options", ["updated_by"], name: "gilead_plan_drug_options_updated_by_idx", using: :btree

  create_table "gilead_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "gilead_plan_drug_settings", ["created_by"], name: "gilead_plan_drug_settings_created_by_idx", using: :btree
  add_index "gilead_plan_drug_settings", ["drug_id"], name: "gilead_plan_drug_settings_drug_id_idx", using: :btree
  add_index "gilead_plan_drug_settings", ["healthplan_id"], name: "gilead_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "gilead_plan_drug_settings", ["plan_drug_option_id"], name: "gilead_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "gilead_plan_drug_settings", ["state_id"], name: "gilead_plan_drug_settings_state_id_idx", using: :btree
  add_index "gilead_plan_drug_settings", ["updated_by"], name: "gilead_plan_drug_settings_updated_by_idx", using: :btree

  create_table "gilead_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gilead_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gilead_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "gilead_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.boolean  "is_super_user",                 default: false
    t.datetime "created_at",                    default: '2010-05-11 12:50:00'
    t.datetime "updated_at",                    default: '2010-05-11 12:50:00'
    t.integer  "restrictions",                  default: 0
  end

  create_table "gilead_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "gilead_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-05-11 12:50:00'
    t.datetime "last_accessed_timestamp",             default: '2010-05-11 12:50:00'
  end

  create_table "gilead_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "gsk_dma_names", force: :cascade do |t|
    t.integer  "dma_id"
    t.string   "site_name",  limit: 100
    t.integer  "active",                 default: 1
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gsk_dma_names", ["dma_id"], name: "gsk_dma_names_dma_id_idx", using: :btree
  add_index "gsk_dma_names", ["updated_by"], name: "gsk_dma_names_updated_by_idx", using: :btree

  create_table "gsk_dma_provider_temp", force: :cascade do |t|
    t.string   "session_id",     limit: 100
    t.integer  "dma_id"
    t.integer  "provider_id"
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "plan_type"
    t.integer  "plan_excluded",              default: 0
    t.string   "drug_status",    limit: 100
    t.integer  "drug_tier"
    t.string   "drug_pa",        limit: 2
    t.string   "drug_ql",        limit: 2
    t.string   "drug_st",        limit: 2
    t.string   "drug_or",        limit: 2
    t.string   "reason_code",    limit: 10
    t.float    "plan_lives"
    t.float    "provider_lives"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gsk_dma_provider_temp", ["dma_id"], name: "gsk_dma_provider_temp_dma_id_idx", using: :btree
  add_index "gsk_dma_provider_temp", ["drug_id"], name: "gsk_dma_provider_temp_drug_id_idx", using: :btree
  add_index "gsk_dma_provider_temp", ["healthplan_id"], name: "gsk_dma_provider_temp_healthplan_id_idx", using: :btree
  add_index "gsk_dma_provider_temp", ["provider_id"], name: "gsk_dma_provider_temp_provider_id_idx", using: :btree

  create_table "gsk_formularies", force: :cascade do |t|
    t.integer  "active",                           default: 1
    t.integer  "published",                        default: 0
    t.integer  "site_user_id"
    t.datetime "published_at"
    t.string   "title",                limit: 100
    t.string   "version",              limit: 100
    t.integer  "version_number",                   default: 0
    t.string   "template",             limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.integer  "dma_id"
    t.string   "geographic_area",      limit: 255
    t.string   "spotlight_drug_list",  limit: 255
    t.string   "competitor_drug_list", limit: 255
    t.string   "provider_order_list",  limit: 255
    t.string   "plan_order_list",      limit: 255
    t.string   "rep_name",             limit: 255
    t.boolean  "display_restrictions",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gsk_formularies", ["dma_id"], name: "gsk_formularies_dma_id_idx", using: :btree
  add_index "gsk_formularies", ["drug_class_id"], name: "gsk_formularies_drug_class_id_idx", using: :btree
  add_index "gsk_formularies", ["site_user_id"], name: "gsk_formularies_site_user_id_idx", using: :btree
  add_index "gsk_formularies", ["state_id"], name: "gsk_formularies_state_id_idx", using: :btree
  add_index "gsk_formularies", ["template"], name: "gsk_formularies_template_idx", using: :btree

  create_table "gsk_formulary_order_addresses", force: :cascade do |t|
    t.integer  "site_user_id"
    t.integer  "site_formulary_order_id"
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "address_1",               limit: 255
    t.string   "address_2",               limit: 255
    t.string   "city",                    limit: 255
    t.integer  "state_id"
    t.string   "zip_code",                limit: 255
    t.string   "telephone_1",             limit: 255
    t.string   "telephone_2",             limit: 255
    t.string   "telephone_3",             limit: 255
    t.string   "telephone_4",             limit: 255
    t.string   "email",                   limit: 255
    t.boolean  "store",                               default: false
    t.integer  "lock_version",                        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gsk_formulary_order_addresses", ["site_formulary_order_id"], name: "gsk_formulary_order_addresses_site_formulary_order_id_idx", using: :btree
  add_index "gsk_formulary_order_addresses", ["site_user_id"], name: "gsk_formulary_order_addresses_site_user_id_idx", using: :btree
  add_index "gsk_formulary_order_addresses", ["state_id"], name: "gsk_formulary_order_addresses_state_id_idx", using: :btree

  create_table "gsk_formulary_order_defaults", force: :cascade do |t|
    t.integer  "site_role_id"
    t.integer  "drug_id"
    t.integer  "ff_publisher_template_id",             null: false
    t.integer  "quantity"
    t.integer  "lock_version",             default: 0
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gsk_formulary_order_defaults", ["ff_publisher_template_id"], name: "gsk_formulary_order_defaults_ff_publisher_template_id_idx", using: :btree
  add_index "gsk_formulary_order_defaults", ["site_role_id"], name: "gsk_formulary_order_defaults_site_role_id_idx", using: :btree
  add_index "gsk_formulary_order_defaults", ["updated_by"], name: "gsk_formulary_order_defaults_updated_by_idx", using: :btree

  create_table "gsk_formulary_order_users", force: :cascade do |t|
    t.integer  "site_user_id"
    t.integer  "drug_id"
    t.integer  "quantity"
    t.integer  "lock_version", default: 0
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gsk_formulary_order_users", ["drug_id"], name: "gsk_formulary_order_users_drug_id_idx", using: :btree
  add_index "gsk_formulary_order_users", ["site_user_id"], name: "gsk_formulary_order_users_site_user_id_idx", using: :btree
  add_index "gsk_formulary_order_users", ["updated_by"], name: "gsk_formulary_order_users_updated_by_idx", using: :btree

  create_table "gsk_formulary_orders", force: :cascade do |t|
    t.integer  "site_user_id"
    t.integer  "site_formulary_id"
    t.integer  "lock_version",                  default: 0
    t.boolean  "order_sent",                    default: false, null: false
    t.string   "pdf_file",          limit: 255,                 null: false
    t.boolean  "pdf_ftp",                       default: false, null: false
    t.boolean  "txt_ftp",                       default: false, null: false
    t.integer  "quantity"
    t.boolean  "special_dl",                    default: false
    t.text     "order_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gsk_formulary_orders", ["site_formulary_id"], name: "gsk_formulary_orders_site_formulary_id_idx", using: :btree
  add_index "gsk_formulary_orders", ["site_user_id"], name: "gsk_formulary_orders_site_user_id_idx", using: :btree

  create_table "gsk_plan_exclusions", force: :cascade do |t|
    t.boolean  "active",        default: true
    t.integer  "drugclass_id"
    t.integer  "drug_id"
    t.integer  "provider_id"
    t.integer  "healthplan_id"
    t.integer  "site_user_id"
    t.boolean  "exclude_batch", default: true
    t.boolean  "exclude_table", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gsk_plan_exclusions", ["drug_id"], name: "gsk_plan_exclusions_drug_id_idx", using: :btree
  add_index "gsk_plan_exclusions", ["drugclass_id"], name: "gsk_plan_exclusions_drugclass_id_idx", using: :btree
  add_index "gsk_plan_exclusions", ["healthplan_id"], name: "gsk_plan_exclusions_healthplan_id_idx", using: :btree
  add_index "gsk_plan_exclusions", ["provider_id"], name: "gsk_plan_exclusions_provider_id_idx", using: :btree
  add_index "gsk_plan_exclusions", ["site_user_id"], name: "gsk_plan_exclusions_site_user_id_idx", using: :btree

  create_table "gsk_provider_custom", force: :cascade do |t|
    t.integer  "provider_id"
    t.string   "name",        limit: 255
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gsk_provider_custom", ["provider_id"], name: "gsk_provider_custom_provider_id_idx", using: :btree

  create_table "gsk_provider_exclusions", force: :cascade do |t|
    t.boolean  "active",      default: true
    t.integer  "provider_id"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gsk_provider_exclusions", ["provider_id"], name: "gsk_provider_exclusions_provider_id_idx", using: :btree

  create_table "gsk_roles", force: :cascade do |t|
    t.string   "role",             limit: 200
    t.string   "description",      limit: 200
    t.integer  "active",                       default: 1
    t.integer  "adminonly",                    default: 0
    t.integer  "admin_tab",                    default: 0
    t.integer  "analytics",                    default: 0
    t.integer  "createtable",                  default: 0
    t.integer  "manage_users",                 default: 0
    t.integer  "myprofile",                    default: 1
    t.integer  "reporting",                    default: 1
    t.integer  "request_account",              default: 0
    t.integer  "requiresapproval",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "search_tables",                default: 0
    t.integer  "create_order",                 default: 1
  end

  create_table "gsk_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2009-10-29 13:42:56'
    t.datetime "last_accessed_timestamp",             default: '2009-10-29 13:42:56'
  end

  create_table "gsk_users", force: :cascade do |t|
    t.string   "activationkey",    limit: 50
    t.integer  "active",                       default: 0
    t.integer  "alerts",                       default: 0
    t.integer  "approved",                     default: 0
    t.string   "email",            limit: 255
    t.string   "password",         limit: 40
    t.string   "login",            limit: 255
    t.string   "first_name",       limit: 200
    t.string   "last_name",        limit: 200
    t.datetime "last_roster_date"
    t.boolean  "password_expired",             default: false, null: false
    t.integer  "site_role_id"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gskrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "gskuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "gskuser", ["email"], name: "gskuser_email_key", unique: true, using: :btree

  create_table "gskusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "health_plan_copy_tier_mapping", id: false, force: :cascade do |t|
    t.integer "source_health_plan_display_id", null: false
    t.integer "copy_health_plan_display_id",   null: false
    t.integer "source_plan_tier_fid",          null: false
    t.integer "copy_plan_tier_fid",            null: false
  end

  create_table "health_plan_effective_date", id: false, force: :cascade do |t|
    t.integer "health_plan_display_id"
    t.date    "effective_date"
    t.date    "end_date"
  end

  add_index "health_plan_effective_date", ["health_plan_display_id"], name: "health_plan_effective_date_health_plan_display_id_key", unique: true, using: :btree
  add_index "health_plan_effective_date", ["health_plan_display_id"], name: "health_plan_effective_date_search_ind", using: :btree

  create_table "health_plan_metal_health_plans", id: false, force: :cascade do |t|
    t.integer "health_plan_metal_id", null: false
    t.integer "health_plan_id",       null: false
  end

  add_index "health_plan_metal_health_plans", ["health_plan_id"], name: "index_health_plan_medal_health_plans_on_health_plan_id", using: :btree
  add_index "health_plan_metal_health_plans", ["health_plan_metal_id"], name: "index_health_plan_medal_health_plans_on_health_plan_medal_id", using: :btree

  create_table "health_plan_metals", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "health_plan_qualifier_forms", force: :cascade do |t|
    t.integer  "health_plan_id",                               null: false
    t.integer  "qualifier_id",               default: 2,       null: false
    t.integer  "drug_class_id"
    t.integer  "drug_id"
    t.string   "form_url",       limit: 500,                   null: false
    t.boolean  "is_active",                  default: true
    t.integer  "created_by",                                   null: false
    t.datetime "created_at",                 default: "now()", null: false
    t.integer  "updated_by",                                   null: false
    t.datetime "updated_at",                 default: "now()", null: false
  end

  create_table "health_plan_type_aggregates", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "legacy_mapping", limit: 255
  end

  create_table "health_plan_type_groups", force: :cascade do |t|
    t.string "name",         limit: 10
    t.string "display_name", limit: 20
  end

  create_table "health_plans_wk_plans", force: :cascade do |t|
    t.integer "health_plan_id", null: false
    t.integer "wk_plan_id",     null: false
  end

  add_index "health_plans_wk_plans", ["health_plan_id", "wk_plan_id"], name: "health_plans_wk_plans_ffwk", unique: true, using: :btree
  add_index "health_plans_wk_plans", ["health_plan_id"], name: "health_plans_wk_plans_health_plan_id", using: :btree
  add_index "health_plans_wk_plans", ["wk_plan_id"], name: "health_plans_wk_plans_wk_plan_id", using: :btree

  create_table "healthplan", force: :cascade do |t|
    t.integer  "healthplantypefid"
    t.boolean  "isactive",                                                null: false
    t.string   "name",                        limit: 255,                 null: false
    t.string   "webname",                     limit: 255,                 null: false
    t.string   "rewritename",                 limit: 255,                 null: false
    t.string   "bookname",                    limit: 255
    t.string   "formularyurl",                limit: 500
    t.integer  "formularyfid"
    t.boolean  "comingsoon",                              default: false, null: false
    t.integer  "legacyfid"
    t.integer  "providerfid"
    t.datetime "createtimestamp"
    t.datetime "modifytimestamp"
    t.integer  "pbmhealthplanfid"
    t.integer  "displayid",                               default: 0,     null: false
    t.string   "qualifierurl",                limit: 500
    t.integer  "comingformularyfid"
    t.datetime "comingformularydate"
    t.datetime "pbmlastupdated"
    t.string   "comingformularynote",         limit: 250
    t.integer  "formularycopy",                           default: 0,     null: false
    t.text     "assignment_comment"
    t.string   "formularyname",               limit: 255
    t.integer  "tiers"
    t.string   "tierstructure",               limit: 255
    t.string   "ptdates",                     limit: 255
    t.string   "ptmembers",                   limit: 255
    t.string   "ptcomments",                  limit: 255
    t.integer  "corporatestructure"
    t.string   "county_url",                  limit: 500
    t.text     "county_comment"
    t.integer  "existing_formularyfid"
    t.integer  "existing_comingformularyfid"
  end

  add_index "healthplan", ["comingformularyfid"], name: "healthplan_comingformularyfid_idx", using: :btree
  add_index "healthplan", ["displayid"], name: "healthplan_displayid_unique", unique: true, using: :btree
  add_index "healthplan", ["formularyfid"], name: "healthplan_formularyfid_idx", using: :btree
  add_index "healthplan", ["healthplantypefid"], name: "healthplan_healthplantypefid_idx", using: :btree
  add_index "healthplan", ["isactive"], name: "healthplan_isactive_idx", using: :btree
  add_index "healthplan", ["name"], name: "healthplan_name_key", unique: true, using: :btree
  add_index "healthplan", ["providerfid"], name: "healthplan_providerfid_idx", using: :btree
  add_index "healthplan", ["rewritename"], name: "healthplan_rewritename_key", unique: true, using: :btree

  create_table "healthplan_copy", force: :cascade do |t|
    t.integer  "healthplanfid",                                   null: false
    t.integer  "healthplancopyfid",                               null: false
    t.datetime "modified",                      default: "now()", null: false
    t.string   "comment",           limit: 500
  end

  add_index "healthplan_copy", ["healthplancopyfid"], name: "healthplancopyfid_idx", unique: true, using: :btree

  create_table "healthplan_countylives", force: :cascade do |t|
    t.integer  "healthplanfid"
    t.integer  "statefid"
    t.integer  "countyfid"
    t.integer  "metrostatareafid"
    t.decimal  "lives"
    t.integer  "importtypefid"
    t.datetime "modifytimestamp"
    t.integer  "modifyuser"
  end

  add_index "healthplan_countylives", ["countyfid"], name: "healthplan_countylives_county_idx", using: :btree
  add_index "healthplan_countylives", ["healthplanfid", "countyfid"], name: "healthplan_countylives_healthplanfid_countyfid_idx", using: :btree
  add_index "healthplan_countylives", ["healthplanfid", "countyfid"], name: "plan_county", unique: true, using: :btree
  add_index "healthplan_countylives", ["healthplanfid", "metrostatareafid"], name: "healthplan_countylives_healthplanfid_metrostatarea_idx", using: :btree
  add_index "healthplan_countylives", ["healthplanfid", "statefid"], name: "healthplan_countylives_healthplanfid_statefid_idx", using: :btree
  add_index "healthplan_countylives", ["healthplanfid"], name: "healthplan_countylives_healthplan_idx", using: :btree
  add_index "healthplan_countylives", ["metrostatareafid"], name: "healthplan_countylives_metrostatarea_idx", using: :btree
  add_index "healthplan_countylives", ["statefid"], name: "healthplan_countylives_state_idx", using: :btree

  create_table "healthplan_countylives_archive", force: :cascade do |t|
    t.integer  "healthplanfid"
    t.integer  "statefid"
    t.integer  "countyfid"
    t.integer  "metrostatareafid"
    t.decimal  "lives"
    t.integer  "importtypefid",    null: false
    t.datetime "modifytimestamp",  null: false
    t.integer  "modifyuser",       null: false
    t.datetime "archivetimestamp", null: false
  end

  add_index "healthplan_countylives_archive", ["countyfid"], name: "healthplan_countylives_archive_county_idx", using: :btree
  add_index "healthplan_countylives_archive", ["healthplanfid"], name: "healthplan_countylives_archive_healthplan_idx", using: :btree
  add_index "healthplan_countylives_archive", ["metrostatareafid"], name: "healthplan_countylives_archive_metrostatarea_idx", using: :btree
  add_index "healthplan_countylives_archive", ["statefid"], name: "healthplan_countylives_archive_state_idx", using: :btree

  create_table "healthplan_countylives_hli_staging", force: :cascade do |t|
    t.integer  "healthplan_id",                                                                     null: false
    t.integer  "county_id",                                                                         null: false
    t.integer  "hli_company_id",                                                                    null: false
    t.decimal  "original_allocation_lives",             precision: 14, scale: 4
    t.decimal  "allocation_percent",                    precision: 4,  scale: 1
    t.integer  "import_type_id",                                                                    null: false
    t.boolean  "is_on_hold",                                                     default: true
    t.date     "import_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",                                                                        null: false
    t.integer  "updated_by"
    t.string   "source_key",                limit: 255,                          default: "import", null: false
    t.decimal  "reallocated_lives",                     precision: 14, scale: 4
    t.decimal  "final_adjusted_lives",                  precision: 14, scale: 4
    t.string   "plan_type_group",           limit: 255
  end

  add_index "healthplan_countylives_hli_staging", ["county_id"], name: "index_healthplan_countylives_hli_staging_on_county_id", using: :btree
  add_index "healthplan_countylives_hli_staging", ["healthplan_id"], name: "index_healthplan_countylives_hli_staging_on_healthplan_id", using: :btree
  add_index "healthplan_countylives_hli_staging", ["hli_company_id"], name: "index_healthplan_countylives_hli_staging_on_hli_company_id", using: :btree

  create_table "healthplan_countylives_staging", force: :cascade do |t|
    t.integer  "healthplanfid"
    t.integer  "statefid"
    t.integer  "countyfid"
    t.integer  "metrostatareafid"
    t.decimal  "lives"
    t.integer  "importtypefid",    null: false
    t.datetime "modifytimestamp",  null: false
    t.integer  "modifyuser",       null: false
  end

  add_index "healthplan_countylives_staging", ["countyfid"], name: "healthplan_countylives_staging_county_idx", using: :btree
  add_index "healthplan_countylives_staging", ["healthplanfid", "countyfid"], name: "plan_county_uk", unique: true, using: :btree
  add_index "healthplan_countylives_staging", ["healthplanfid"], name: "healthplan_countylives_staging_healthplan_idx", using: :btree
  add_index "healthplan_countylives_staging", ["metrostatareafid"], name: "healthplan_countylives_staging_metrostatarea_idx", using: :btree
  add_index "healthplan_countylives_staging", ["statefid"], name: "healthplan_countylives_staging_state_idx", using: :btree

  create_table "healthplanaddress", force: :cascade do |t|
    t.integer "healthplanfid", null: false
    t.integer "addressfid",    null: false
  end

  add_index "healthplanaddress", ["healthplanfid", "addressfid"], name: "healthplanaddress_healthplanfid_key", unique: true, using: :btree

  create_table "healthplanallocation", force: :cascade do |t|
    t.integer  "healthplanfid",                            null: false
    t.integer  "providergroupfid"
    t.integer  "allocation",                   default: 0, null: false
    t.datetime "modifytimestamp",                          null: false
    t.integer  "modifyuser",                               null: false
    t.string   "contract_id",      limit: 255
  end

  add_index "healthplanallocation", ["healthplanfid", "contract_id"], name: "healthplan_allocation_uk", unique: true, using: :btree

  create_table "healthplancomment", force: :cascade do |t|
    t.integer "healthplanfid",             null: false
    t.integer "commentfid",                null: false
    t.integer "commenttype",   default: 1, null: false
  end

  add_index "healthplancomment", ["healthplanfid", "commentfid"], name: "healthplancomment_healthplanfid_key", unique: true, using: :btree

  create_table "healthplancommenttypes", force: :cascade do |t|
    t.string "description", limit: 50
  end

  create_table "healthplancontact", force: :cascade do |t|
    t.integer "healthplanfid", null: false
    t.integer "contactfid",    null: false
  end

  add_index "healthplancontact", ["healthplanfid", "contactfid"], name: "healthplancontact_healthplanfid_key", unique: true, using: :btree

  create_table "healthplancounty", force: :cascade do |t|
    t.integer "healthplanfid"
    t.integer "countyfid"
  end

  add_index "healthplancounty", ["countyfid"], name: "healthplancounty_county_idx", using: :btree
  add_index "healthplancounty", ["healthplanfid", "countyfid"], name: "healthplancounty_healthplanfid_countyfid_idx", using: :btree
  add_index "healthplancounty", ["healthplanfid"], name: "healthplancounty_healthplan_idx", using: :btree

  create_table "healthplanlivesarchive", id: :bigserial, force: :cascade do |t|
    t.integer "healthplanfid",             null: false
    t.integer "statefid",                  null: false
    t.integer "lives",                     null: false
    t.integer "year",                      null: false
    t.integer "month",                     null: false
    t.integer "status",        default: 0
  end

  add_index "healthplanlivesarchive", ["healthplanfid", "statefid", "year", "month"], name: "healthplanlivesarchive_healthplanfid_key", unique: true, using: :btree

  create_table "healthplanlog", force: :cascade do |t|
    t.integer  "healthplanfid",                                null: false
    t.integer  "eventfid",                                     null: false
    t.string   "oldoperstates",  limit: 500
    t.string   "newoperstates",  limit: 500
    t.datetime "createddate",                default: "now()", null: false
    t.integer  "createduserfid",             default: 0,       null: false
    t.integer  "reviewed",                   default: 0,       null: false
    t.datetime "revieweddate",               default: "now()"
    t.integer  "reviewduserfid",             default: 0
  end

  create_table "healthplanlogevent", force: :cascade do |t|
    t.string "event", limit: 100, null: false
  end

  create_table "healthplanmanagement", force: :cascade do |t|
    t.string  "name",          limit: 200, null: false
    t.integer "healthplanfid",             null: false
    t.string  "title",         limit: 200, null: false
  end

  create_table "healthplanmanagement_type", force: :cascade do |t|
    t.string  "name",    limit: 200, null: false
    t.integer "orderid",             null: false
  end

  create_table "healthplannotes", force: :cascade do |t|
    t.integer "healthplanfid",             null: false
    t.integer "notesfid",                  null: false
    t.integer "active",        default: 1, null: false
  end

  create_table "healthplanpbm", force: :cascade do |t|
    t.integer  "healthplanfid",    null: false
    t.integer  "pbmfid",           null: false
    t.integer  "pbmfunctionfid"
    t.datetime "pbmlastupdated"
    t.datetime "pbmeffectivedate"
  end

  add_index "healthplanpbm", ["pbmfunctionfid"], name: "healthplanpbm_pbmfunctionfid_idx", using: :btree

  create_table "healthplanpbm_temp", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "healthplanfid"
    t.integer  "pbmfid"
    t.integer  "pbmfunctionfid"
    t.datetime "pbmlastupdated"
    t.datetime "pbmeffectivedate"
  end

  create_table "healthplanpbmhistory", force: :cascade do |t|
    t.integer  "healthplanfid",  null: false
    t.integer  "pbmfid"
    t.integer  "pbmfunctionfid"
    t.datetime "pbmlastupdated"
  end

  create_table "healthplanpeople", force: :cascade do |t|
    t.integer "healthplanfid",             null: false
    t.integer "peoplefid",                 null: false
    t.integer "active",        default: 1, null: false
  end

  create_table "healthplanreportentry", force: :cascade do |t|
    t.integer "reportentryfid",                            null: false
    t.integer "healthplanfid",                             null: false
    t.string  "notes",          limit: 255
    t.boolean "isactive",                   default: true, null: false
  end

  create_table "healthplanstate", force: :cascade do |t|
    t.integer "healthplanfid", null: false
    t.integer "statefid"
  end

  add_index "healthplanstate", ["healthplanfid", "statefid"], name: "healthplanstate_healthplanfid_key", unique: true, using: :btree
  add_index "healthplanstate", ["healthplanfid"], name: "healthplanstate_healthplanfid_idx", using: :btree
  add_index "healthplanstate", ["statefid"], name: "healthplanstate_statefid_idx", using: :btree

  create_table "healthplantype", force: :cascade do |t|
    t.boolean "isactive",                                  null: false
    t.string  "name",                          limit: 255, null: false
    t.string  "webname",                       limit: 255, null: false
    t.text    "explanationtext"
    t.boolean "iscommercial",                              null: false
    t.boolean "ismedicare",                                null: false
    t.integer "health_plan_type_group_id"
    t.integer "health_plan_type_aggregate_id"
  end

  add_index "healthplantype", ["name"], name: "healthplantype_name_key", unique: true, using: :btree
  add_index "healthplantype", ["webname"], name: "healthplantype_webname_key", unique: true, using: :btree

  create_table "hli_ff_plan_allocation", force: :cascade do |t|
    t.integer  "hli_ff_provider_id",                                                        null: false
    t.integer  "hli_company_id",                                                            null: false
    t.integer  "ff_healthplan_id",                                                          null: false
    t.decimal  "allocation_percent",             precision: 4, scale: 1
    t.date     "import_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",                                                                null: false
    t.integer  "updated_by",                                                                null: false
    t.string   "source_key",         limit: 255,                         default: "import", null: false
  end

  add_index "hli_ff_plan_allocation", ["ff_healthplan_id"], name: "index_hli_ff_plan_allocation_on_ff_healthplan_id", using: :btree
  add_index "hli_ff_plan_allocation", ["hli_company_id"], name: "index_hli_ff_plan_allocation_on_hli_company_id", using: :btree

  create_table "hli_ff_plan_allocation_notes", force: :cascade do |t|
    t.integer  "hli_ff_provider_id", null: false
    t.integer  "hli_company_id",     null: false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",         null: false
    t.integer  "updated_by",         null: false
  end

  add_index "hli_ff_plan_allocation_notes", ["hli_company_id"], name: "index_hli_ff_plan_allocation_notes_on_hli_company_id", using: :btree
  add_index "hli_ff_plan_allocation_notes", ["hli_ff_provider_id", "hli_company_id"], name: "index_hli_ff_plan_allocation_notes_on_hli_ff_provider_id_and_hl", using: :btree
  add_index "hli_ff_plan_allocation_notes", ["hli_ff_provider_id"], name: "index_hli_ff_plan_allocation_notes_on_hli_ff_provider_id", using: :btree

  create_table "hli_ff_provider_mapping", force: :cascade do |t|
    t.integer  "hli_managed_care_company_id",                                  null: false
    t.string   "hli_managed_care_company_name", limit: 255,                    null: false
    t.integer  "hli_company_id",                                               null: false
    t.string   "hli_company_name",              limit: 255,                    null: false
    t.integer  "ff_provider_id"
    t.integer  "exclude_lives"
    t.date     "import_date",                                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",                                                   null: false
    t.integer  "updated_by",                                                   null: false
    t.string   "source_key",                    limit: 255, default: "import", null: false
  end

  add_index "hli_ff_provider_mapping", ["ff_provider_id"], name: "index_hli_ff_provider_mapping_on_ff_provider_id", using: :btree
  add_index "hli_ff_provider_mapping", ["hli_company_id"], name: "index_hli_ff_provider_mapping_on_hli_company_id", using: :btree

  create_table "hli_lives_county_other_staging", force: :cascade do |t|
    t.integer  "ff_provider_id",   null: false
    t.integer  "state_id",         null: false
    t.integer  "hli_company_id",   null: false
    t.float    "commercial_lives"
    t.float    "medicaid_lives"
    t.integer  "fake_fips",        null: false
    t.date     "import_date",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",       null: false
  end

  add_index "hli_lives_county_other_staging", ["ff_provider_id"], name: "index_hli_lives_county_other_staging_on_ff_provider_id", using: :btree
  add_index "hli_lives_county_other_staging", ["hli_company_id"], name: "index_hli_lives_county_other_staging_on_hli_company_id", using: :btree
  add_index "hli_lives_county_other_staging", ["state_id"], name: "index_hli_lives_county_other_staging_on_state_id", using: :btree

  create_table "hli_lives_data", force: :cascade do |t|
    t.integer  "hli_import_batch_id"
    t.integer  "hli_managed_care_company_id"
    t.string   "hli_managed_care_company_name",         limit: 255
    t.integer  "hli_company_id"
    t.string   "hli_company_name",                      limit: 255
    t.integer  "hli_county_id"
    t.integer  "fips_county_id"
    t.string   "state_abbreviation",                    limit: 255
    t.integer  "hli_commercial_rx_enrollment"
    t.integer  "hli_medicaid_rx_enrollment"
    t.integer  "hli_medicare_advantage_pdp_enrollment"
    t.integer  "hli_stand_alone_pdp_enrollment"
    t.date     "import_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hli_lives_data", ["fips_county_id"], name: "index_hli_lives_data_on_fips_county_id", using: :btree
  add_index "hli_lives_data", ["hli_company_id"], name: "index_hli_lives_data_on_hli_company_id", using: :btree

  create_table "hli_lives_data_archive", force: :cascade do |t|
    t.integer  "hli_import_batch_id"
    t.integer  "hli_managed_care_company_id"
    t.string   "hli_managed_care_company_name",         limit: 255
    t.integer  "hli_company_id"
    t.string   "hli_company_name",                      limit: 255
    t.integer  "hli_county_id"
    t.integer  "fips_county_id"
    t.string   "state_abbreviation",                    limit: 255
    t.integer  "hli_commercial_rx_enrollment"
    t.integer  "hli_medicaid_rx_enrollment"
    t.integer  "hli_medicare_advantage_pdp_enrollment"
    t.integer  "hli_stand_alone_pdp_enrollment"
    t.date     "import_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source_key",                            limit: 255, default: "import", null: false
  end

  add_index "hli_lives_data_archive", ["fips_county_id"], name: "index_hli_lives_data_archive_on_fips_county_id", using: :btree
  add_index "hli_lives_data_archive", ["hli_company_id"], name: "index_hli_lives_data_archive_on_hli_company_id", using: :btree

  create_table "hli_lives_state_other_staging", force: :cascade do |t|
    t.integer  "ff_provider_id",   null: false
    t.integer  "hli_company_id",   null: false
    t.float    "commercial_lives"
    t.float    "medicaid_lives"
    t.integer  "fake_fips",        null: false
    t.date     "import_date",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",       null: false
  end

  add_index "hli_lives_state_other_staging", ["ff_provider_id"], name: "index_hli_lives_state_other_staging_on_ff_provider_id", using: :btree
  add_index "hli_lives_state_other_staging", ["hli_company_id"], name: "index_hli_lives_state_other_staging_on_hli_company_id", using: :btree

  create_table "hli_medical_benefit_design_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hli_medical_benefit_design_categories", ["name"], name: "index_hli_medical_benefit_design_categories_on_name", using: :btree

  create_table "hli_medical_benefit_designs", force: :cascade do |t|
    t.string   "name",                                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hli_medical_benefit_design_category_id"
  end

  add_index "hli_medical_benefit_designs", ["name"], name: "index_hli_medical_benefit_designs_on_name", using: :btree

  create_table "hli_medical_benefit_lives", force: :cascade do |t|
    t.integer  "hli_medical_benefit_lives_import_id"
    t.integer  "provider_id"
    t.integer  "county_id"
    t.integer  "hli_medical_benefit_design_id"
    t.integer  "lives_imported",                      default: 0
    t.integer  "lives_allocated",                     default: 0
    t.integer  "lives_adjusted",                      default: 0
    t.integer  "lives",                               default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hli_medical_benefit_lives", ["county_id"], name: "index_hli_medical_benefit_lives_on_county_id", using: :btree
  add_index "hli_medical_benefit_lives", ["hli_medical_benefit_design_id"], name: "hli_mb_design_id_index", using: :btree
  add_index "hli_medical_benefit_lives", ["hli_medical_benefit_lives_import_id"], name: "hli_mb_import_id_index", using: :btree
  add_index "hli_medical_benefit_lives", ["provider_id", "county_id", "hli_medical_benefit_design_id"], name: "hli_mb_provider_county_design_index", using: :btree
  add_index "hli_medical_benefit_lives", ["provider_id"], name: "index_hli_medical_benefit_lives_on_provider_id", using: :btree

  create_table "hli_medical_benefit_lives_imports", force: :cascade do |t|
    t.string   "import_code",                          limit: 255
    t.string   "managed_care_company_code",            limit: 255
    t.string   "managed_care_company_name",            limit: 255
    t.integer  "company_id"
    t.string   "company_name",                         limit: 255
    t.string   "state_abbreviation",                   limit: 255
    t.string   "county",                               limit: 255
    t.integer  "fips_code"
    t.integer  "total_enrollment_lives"
    t.integer  "total_enrollment_lives_fully_insured"
    t.float    "total_market_share_percent"
    t.float    "commercial_market_share_percent"
    t.integer  "commercial_lives_fully_insured"
    t.integer  "commercial_lives_self_insured"
    t.integer  "hmo_lives_fully_insured"
    t.integer  "hmo_lives_self_insured"
    t.integer  "ppo_lives_fully_insured"
    t.integer  "ppo_lives_self_insured"
    t.integer  "pos_lives_fully_insured"
    t.integer  "pos_lives_self_insured"
    t.integer  "indemnity_lives_fully_insured"
    t.integer  "indemnity_lives_self_insured"
    t.integer  "other_lives"
    t.integer  "medicare_lives"
    t.integer  "medicaid_lives"
    t.string   "category",                             limit: 255
    t.datetime "staged_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hli_medical_benefit_lives_imports", ["company_id"], name: "index_hli_medical_benefit_lives_imports_on_company_id", using: :btree
  add_index "hli_medical_benefit_lives_imports", ["fips_code"], name: "index_hli_medical_benefit_lives_imports_on_fips_code", using: :btree
  add_index "hli_medical_benefit_lives_imports", ["import_code"], name: "index_hli_medical_benefit_lives_imports_on_import_code", using: :btree
  add_index "hli_medical_benefit_lives_imports", ["state_abbreviation"], name: "index_hli_medical_benefit_lives_imports_on_state_abbreviation", using: :btree

  create_table "hli_medical_benefit_lives_logs", force: :cascade do |t|
    t.string   "import_code",  limit: 255
    t.datetime "imported_at"
    t.datetime "staged_at"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hli_medical_benefit_lives_staging", force: :cascade do |t|
    t.integer  "hli_medical_benefit_lives_import_id"
    t.integer  "provider_id"
    t.integer  "county_id"
    t.integer  "hli_medical_benefit_design_id"
    t.integer  "lives_imported",                      default: 0
    t.integer  "lives_allocated",                     default: 0
    t.integer  "lives_adjusted",                      default: 0
    t.integer  "lives",                               default: 0
    t.boolean  "on_hold",                             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "released_at"
  end

  add_index "hli_medical_benefit_lives_staging", ["county_id"], name: "index_hli_medical_benefit_lives_staging_on_county_id", using: :btree
  add_index "hli_medical_benefit_lives_staging", ["hli_medical_benefit_design_id"], name: "hli_mb_staging_design_id_index", using: :btree
  add_index "hli_medical_benefit_lives_staging", ["hli_medical_benefit_lives_import_id"], name: "hli_mb_staging_import_id_index", using: :btree
  add_index "hli_medical_benefit_lives_staging", ["provider_id", "county_id", "hli_medical_benefit_design_id"], name: "hli_mb_staging_provider_county_design_index", using: :btree
  add_index "hli_medical_benefit_lives_staging", ["provider_id"], name: "index_hli_medical_benefit_lives_staging_on_provider_id", using: :btree

  create_table "howheard", force: :cascade do |t|
    t.boolean "isactive",             default: true, null: false
    t.string  "name",     limit: 200,                null: false
  end

  create_table "impax_drug_plan_labels", force: :cascade do |t|
    t.integer  "drug_id"
    t.integer  "health_plan_id"
    t.integer  "label_id"
    t.datetime "created_at",     default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",     default: "now()"
    t.integer  "updated_by"
    t.boolean  "is_active",      default: true
  end

  create_table "impax_plan_administration_filter", id: false, force: :cascade do |t|
    t.integer  "healthplanid_fk"
    t.datetime "create_stamp",    default: "now()"
  end

  create_table "impax_template_labels", force: :cascade do |t|
    t.integer  "template_id"
    t.string   "label",         limit: 50
    t.boolean  "unrestricted",             default: false
    t.integer  "display_order", limit: 2
    t.datetime "created_at",               default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",               default: "now()"
    t.integer  "updated_by"
    t.boolean  "is_active",                default: true
  end

  create_table "impaxformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                  limit: 8,               null: false
    t.integer  "statefid",                 limit: 8,               null: false
    t.integer  "msafid",                   limit: 8,   default: 0
    t.integer  "drugclassfid",             limit: 8,               null: false
    t.string   "planlist",                                         null: false
    t.string   "druglist",                                         null: false
    t.string   "tableversion",             limit: 100,             null: false
    t.integer  "versionnumber",            limit: 8,   default: 0, null: false
    t.integer  "ispublished",              limit: 8,   default: 0, null: false
    t.integer  "isexported",               limit: 8,   default: 0, null: false
    t.integer  "isactive",                 limit: 8,   default: 1, null: false
    t.datetime "createtimestamp",                                  null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "modifytimestamp",                                  null: false
    t.integer  "mostrecent",               limit: 8,   default: 0, null: false
    t.string   "planorderedlist"
    t.string   "description",              limit: 100
    t.string   "doctorname",               limit: 100
    t.integer  "tabletype",                limit: 8,   default: 1, null: false
    t.string   "template",                 limit: 50
    t.string   "repname",                  limit: 100
    t.integer  "segmenttable",                         default: 0, null: false
    t.string   "localename",               limit: 100
    t.integer  "analyticsheader",                      default: 0, null: false
    t.integer  "displaycompaniontable",                default: 0, null: false
    t.string   "plantype",                 limit: 50
    t.string   "plan_type_category_order", limit: 50
    t.integer  "olduserfid"
    t.string   "old_template_name",        limit: 50
    t.string   "planboldedlist",           limit: 500
    t.string   "competitor_drug_order",    limit: 255
    t.string   "mark_new_list",            limit: 500
    t.integer  "header_option"
    t.integer  "copay_option"
  end

  create_table "impaxrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",        limit: 8,   default: 0, null: false
    t.integer  "requiresapproval", limit: 8,   default: 0, null: false
    t.integer  "createtable",      limit: 8,   default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "impaxuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid",            limit: 8
    t.integer  "isactive",           limit: 8,   default: 0, null: false
    t.integer  "isalerts",           limit: 8,   default: 0, null: false
    t.integer  "isapproved",         limit: 8,   default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "impaxuser", ["email"], name: "impaxuser_email_key", unique: true, using: :btree

  create_table "impaxusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",               limit: 8,               null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",            limit: 8,   default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "importbatch", id: :bigserial, force: :cascade do |t|
    t.datetime "createtimestamp"
    t.string   "batchtype",       limit: 3
    t.string   "datatype",        limit: 16
    t.integer  "year"
    t.integer  "month"
    t.string   "excelfilename",   limit: 255, null: false
  end

  create_table "importcontract", id: :bigserial, force: :cascade do |t|
    t.string   "number",                      limit: 255, null: false
    t.boolean  "isactive",                                null: false
    t.datetime "modifiedtimestamp"
    t.string   "organization_type",           limit: 255
    t.string   "plan_type",                   limit: 255
    t.string   "organization_name",           limit: 255
    t.string   "organization_marketing_name", limit: 255
    t.string   "parent_organization",         limit: 255
    t.datetime "contracteffectivedate"
  end

  create_table "importcontractenrollment", id: :bigserial, force: :cascade do |t|
    t.integer  "importbatchfid"
    t.integer  "importcontractfid"
    t.string   "plantype",           limit: 3, null: false
    t.boolean  "isactive",                     null: false
    t.datetime "modifiedtimestamp"
    t.integer  "contractenrollment"
    t.integer  "statefid"
  end

  create_table "importcontractplan", id: :bigserial, force: :cascade do |t|
    t.integer "importmappingfid"
    t.integer "healthplanfid"
  end

  create_table "importexception", id: :bigserial, force: :cascade do |t|
    t.integer  "importbatchfid"
    t.string   "contractnumber",     limit: 64
    t.string   "plannumber",         limit: 64
    t.integer  "contractenrollment"
    t.string   "state",              limit: 2
    t.string   "county",             limit: 128
    t.boolean  "isactive",                       null: false
    t.datetime "modifiedtimestamp"
    t.string   "message",            limit: 255, null: false
  end

  create_table "importmapping", id: :bigserial, force: :cascade do |t|
    t.integer  "importcontractfid"
    t.integer  "importbatchfid"
    t.boolean  "isactive",                      null: false
    t.datetime "modifiedtimestamp"
    t.string   "notes",             limit: 255
  end

  create_table "ims_mapping", force: :cascade do |t|
    t.integer "old_imsfid"
    t.integer "new_imsfid"
  end

  create_table "imshealthplan", force: :cascade do |t|
    t.integer "healthplanfid", null: false
    t.integer "imsfid",        null: false
  end

  add_index "imshealthplan", ["healthplanfid", "imsfid"], name: "imshealthplan_healthplanfid_key", unique: true, using: :btree

  create_table "imshealthplancomment", force: :cascade do |t|
    t.integer "healthplanfid", null: false
    t.integer "commentfid",    null: false
  end

  add_index "imshealthplancomment", ["healthplanfid", "commentfid"], name: "imshealthplancomment_healthplanfid_key", unique: true, using: :btree

  create_table "imsplan", force: :cascade do |t|
    t.boolean  "isactive",                                                null: false
    t.string   "name",                      limit: 255,                   null: false
    t.integer  "code",                      limit: 8,                     null: false
    t.text     "comments"
    t.integer  "payerid"
    t.string   "payername",                 limit: 255
    t.datetime "createtimestamp",                       default: "now()", null: false
    t.datetime "modifytimestamp"
    t.integer  "statefid"
    t.string   "model",                     limit: 50
    t.integer  "model_id"
    t.string   "pbm_name",                  limit: 255
    t.integer  "health_plan_type_group_id"
  end

  add_index "imsplan", ["code"], name: "imsplan_code_key", unique: true, using: :btree
  add_index "imsplan", ["health_plan_type_group_id"], name: "imsplan_health_plan_type_group_id_idx", using: :btree

  create_table "ip_accesses", force: :cascade do |t|
    t.integer  "token_id"
    t.boolean  "active"
    t.string   "ip",            limit: 255
    t.text     "description"
    t.integer  "octets"
    t.string   "allow_or_deny", limit: 255
    t.string   "level",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ip_accesses", ["token_id"], name: "index_ip_accesses_on_token_id", using: :btree

  create_table "jcodes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jnj_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2011-02-10 11:44:05'
    t.datetime "updated_at",                              default: '2011-02-10 11:44:05'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "jnj_formularies", ["drug_class_id"], name: "jnj_formularies_drug_class_id_idx", using: :btree
  add_index "jnj_formularies", ["site_user_id"], name: "jnj_formularies_site_user_id_idx", using: :btree
  add_index "jnj_formularies", ["state_id"], name: "jnj_formularies_state_id_idx", using: :btree
  add_index "jnj_formularies", ["template"], name: "jnj_formularies_template_idx", using: :btree

  create_table "jnj_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jnj_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jnj_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "jnj_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.boolean  "is_super_user",                 default: false
    t.datetime "created_at",                    default: '2011-02-10 11:44:05'
    t.datetime "updated_at",                    default: '2011-02-10 11:44:05'
    t.integer  "restrictions",                  default: 0
    t.integer  "accounts",                      default: 0
  end

  create_table "jnj_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "jnj_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2011-02-10 11:44:05'
    t.datetime "last_accessed_timestamp",             default: '2011-02-10 11:44:05'
  end

  create_table "jnj_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "jnjrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "jnjuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "jnjuser", ["email"], name: "jnjuser_email_key", unique: true, using: :btree

  create_table "jnjusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "jpg_temp", id: false, force: :cascade do |t|
    t.integer "id",                         default: "nextval('jpg_temp_id_seq'::regclass)", null: false
    t.string  "health_plan",    limit: 255
    t.integer "health_plan_id"
    t.string  "provider",       limit: 255
    t.string  "plan_type",      limit: 255
    t.string  "states",         limit: 500
    t.float   "lives"
    t.string  "drug",           limit: 255
    t.integer "drug_id"
    t.integer "formulary_id"
    t.string  "2006_06",        limit: 255
    t.string  "2006_07",        limit: 255
    t.string  "2006_08",        limit: 255
    t.string  "2006_09",        limit: 255
    t.string  "2006_10",        limit: 255
    t.string  "2006_11",        limit: 255
    t.string  "2006_12",        limit: 255
    t.string  "2007_01",        limit: 255
    t.string  "2007_02",        limit: 255
    t.string  "2007_03",        limit: 255
    t.string  "2007_04",        limit: 255
    t.string  "2007_05",        limit: 255
    t.string  "2007_06",        limit: 255
    t.string  "2007_07",        limit: 255
    t.string  "2007_08",        limit: 255
    t.string  "2007_09",        limit: 255
    t.string  "2007_10",        limit: 255
    t.string  "2007_11",        limit: 255
    t.string  "2007_12",        limit: 255
    t.string  "2008_01",        limit: 255
    t.string  "2008_02",        limit: 255
    t.string  "2008_03",        limit: 255
    t.string  "2008_04",        limit: 255
    t.string  "2008_05",        limit: 255
    t.string  "2008_06",        limit: 255
    t.string  "2008_07",        limit: 255
    t.string  "2008_08",        limit: 255
    t.string  "2008_09",        limit: 255
    t.string  "2008_10",        limit: 255
    t.string  "2008_11",        limit: 255
    t.string  "2008_12",        limit: 255
    t.string  "2009_01",        limit: 255
    t.string  "2009_02",        limit: 255
    t.string  "2009_03",        limit: 255
    t.string  "2009_04",        limit: 255
    t.string  "2009_05",        limit: 255
    t.string  "2009_06",        limit: 255
    t.string  "2009_07",        limit: 255
    t.string  "2009_08",        limit: 255
    t.string  "2009_09",        limit: 255
    t.string  "2009_10",        limit: 255
    t.string  "2009_11",        limit: 255
    t.string  "2009_12",        limit: 255
    t.string  "2010_01",        limit: 255
    t.string  "2010_02",        limit: 255
    t.string  "2010_03",        limit: 255
    t.string  "2010_04",        limit: 255
    t.string  "2010_05",        limit: 255
    t.string  "2010_06",        limit: 255
    t.string  "2010_07",        limit: 255
    t.string  "2010_08",        limit: 255
    t.string  "2010_09",        limit: 255
    t.string  "2010_10",        limit: 255
    t.string  "2010_11",        limit: 255
    t.string  "2010_12",        limit: 255
    t.string  "2011_01",        limit: 255
    t.string  "2011_02",        limit: 255
    t.string  "2011_03",        limit: 255
    t.string  "2011_04",        limit: 255
    t.string  "2011_05",        limit: 255
    t.string  "2011_06",        limit: 255
    t.string  "2011_07",        limit: 255
    t.string  "2011_08",        limit: 255
    t.string  "2011_09",        limit: 255
    t.string  "2011_10",        limit: 255
    t.string  "2011_11",        limit: 255
    t.string  "2011_12",        limit: 255
    t.string  "2012_01",        limit: 255
    t.string  "2012_02",        limit: 255
    t.string  "2012_03",        limit: 255
    t.string  "2012_04",        limit: 255
    t.string  "2012_05",        limit: 255
  end

  create_table "lilly_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2009-08-14 13:38:00'
    t.datetime "updated_at",                              default: '2009-08-14 13:38:00'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "lilly_formularies", ["drug_class_id"], name: "lilly_formularies_drug_class_id_idx", using: :btree
  add_index "lilly_formularies", ["site_user_id"], name: "lilly_formularies_site_user_id_idx", using: :btree
  add_index "lilly_formularies", ["state_id"], name: "lilly_formularies_state_id_idx", using: :btree
  add_index "lilly_formularies", ["template"], name: "lilly_formularies_template_idx", using: :btree

  create_table "lilly_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "lilly_plan_drug_options", ["created_by"], name: "lilly_plan_drug_options_created_by_idx", using: :btree
  add_index "lilly_plan_drug_options", ["updated_by"], name: "lilly_plan_drug_options_updated_by_idx", using: :btree

  create_table "lilly_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "lilly_plan_drug_settings", ["created_by"], name: "lilly_plan_drug_settings_created_by_idx", using: :btree
  add_index "lilly_plan_drug_settings", ["drug_id"], name: "lilly_plan_drug_settings_drug_id_idx", using: :btree
  add_index "lilly_plan_drug_settings", ["healthplan_id"], name: "lilly_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "lilly_plan_drug_settings", ["plan_drug_option_id"], name: "lilly_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "lilly_plan_drug_settings", ["state_id"], name: "lilly_plan_drug_settings_state_id_idx", using: :btree
  add_index "lilly_plan_drug_settings", ["updated_by"], name: "lilly_plan_drug_settings_updated_by_idx", using: :btree

  create_table "lilly_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "lilly_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.datetime "created_at",                    default: '2009-08-14 13:38:00'
    t.datetime "updated_at",                    default: '2009-08-14 13:38:00'
  end

  create_table "lilly_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "lilly_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2009-08-14 13:38:00'
    t.datetime "last_accessed_timestamp",             default: '2009-08-14 13:38:00'
  end

  create_table "lilly_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "lives_allocation_log", force: :cascade do |t|
    t.integer  "create_user",                                  null: false
    t.integer  "providerfid",                                  null: false
    t.string   "plan_list",        limit: 100
    t.string   "description",      limit: 100
    t.datetime "create_timestamp",                             null: false
    t.datetime "modify_timestamp",                             null: false
    t.boolean  "batch_complete",               default: false, null: false
    t.boolean  "email_sent",                   default: false, null: false
  end

  create_table "lundbeck_allocated_claims_unmatched", id: false, force: :cascade do |t|
    t.integer "drug_id"
    t.integer "health_plan_id"
    t.string  "status"
    t.boolean "refill"
    t.integer "original_days_supply"
    t.integer "eligibility_key"
    t.integer "state_id"
    t.integer "msa_id"
    t.integer "county_id"
    t.integer "wk_plan_id"
    t.decimal "allocation"
    t.decimal "allocated_patient_copay_amount"
    t.decimal "allocated_patient_collected_amount"
  end

  create_table "ma_region_code", id: false, force: :cascade do |t|
    t.integer "code"
    t.string  "state", limit: 2
  end

  create_table "mallinckrodtdrugplanform", primary_key: "entityid", force: :cascade do |t|
    t.integer "formularyfid",               null: false
    t.integer "planid",                     null: false
    t.integer "drugid",                     null: false
    t.integer "coveragestatus",             null: false
    t.boolean "priorauth",                  null: false
    t.boolean "quantlimit",                 null: false
    t.boolean "stepther",                   null: false
    t.boolean "restrother",                 null: false
    t.integer "resaoncodefid",  default: 0, null: false
    t.integer "resetflag",      default: 0, null: false
    t.integer "paforall",       default: 0, null: false
  end

  add_index "mallinckrodtdrugplanform", ["drugid"], name: "mallinckrodtdrugplanform_drugid_idx", using: :btree
  add_index "mallinckrodtdrugplanform", ["formularyfid"], name: "mallinckrodtdrugplanform_formularyid_idx", using: :btree
  add_index "mallinckrodtdrugplanform", ["planid"], name: "mallinckrodtdrugplanform_planid_idx", using: :btree

  create_table "mallinckrodtformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.integer  "statefid"
    t.integer  "msafid"
    t.integer  "drugclassfid",                                  null: false
    t.string   "planlist",                                      null: false
    t.string   "druglist",                                      null: false
    t.string   "tableversion",          limit: 100,             null: false
    t.integer  "versionnumber",                     default: 0, null: false
    t.integer  "ispublished",                       default: 0, null: false
    t.integer  "isexported",                        default: 0, null: false
    t.integer  "isactive",                          default: 1, null: false
    t.datetime "createtimestamp",                               null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "modifytimestamp",                               null: false
    t.integer  "mostrecent",                        default: 0, null: false
    t.string   "planorderedlist",       limit: 255
    t.string   "planboldedlist",        limit: 255
    t.string   "commercialplanordered", limit: 255
    t.string   "medicareplanordered",   limit: 255
    t.string   "medicaidplanordered",   limit: 255
    t.string   "description",           limit: 100
    t.string   "doctorname",            limit: 100
    t.integer  "tabletype",                         default: 1, null: false
    t.string   "template",              limit: 50
    t.string   "repname",               limit: 100
  end

  add_index "mallinckrodtformulary", ["drugclassfid"], name: "mallinckrodtformulary_drugclassid_idx", using: :btree
  add_index "mallinckrodtformulary", ["msafid"], name: "mallinckrodtformulary_msaid_idx", using: :btree
  add_index "mallinckrodtformulary", ["statefid"], name: "mallinckrodtformulary_stateid_idx", using: :btree
  add_index "mallinckrodtformulary", ["userfid"], name: "mallinckrodtformulary_userid_idx", using: :btree

  create_table "mallinckrodtmsa", force: :cascade do |t|
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 100
    t.datetime "modified",                default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "mallinckrodtmsahealthplan", force: :cascade do |t|
    t.integer  "msafid",                          null: false
    t.integer  "healthplanfid",                   null: false
    t.integer  "statefid",                        null: false
    t.datetime "modified",      default: "now()", null: false
    t.integer  "active",        default: 1,       null: false
  end

  add_index "mallinckrodtmsahealthplan", ["healthplanfid"], name: "mallinckrodtmsahealthplan_healthplanid_idx", using: :btree
  add_index "mallinckrodtmsahealthplan", ["msafid"], name: "mallinckrodtmsahealthplan_msaid_idx", using: :btree
  add_index "mallinckrodtmsahealthplan", ["statefid"], name: "mallinckrodtmsahealthplan_stateid_idx", using: :btree

  create_table "mallinckrodtmsastate", force: :cascade do |t|
    t.integer  "msafid",                     null: false
    t.integer  "statefid",                   null: false
    t.datetime "modified", default: "now()", null: false
    t.integer  "active",   default: 1,       null: false
  end

  add_index "mallinckrodtmsastate", ["msafid"], name: "mallinckrodtmsastate_msaid_idx", using: :btree

  create_table "mallinckrodtrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "mallinckrodtuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "mallinckrodtuser", ["email"], name: "mallinckrodtuser_email_key", unique: true, using: :btree

  create_table "mallinckrodtusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "manufacturer", force: :cascade do |t|
    t.boolean "isactive",             null: false
    t.string  "name",     limit: 255, null: false
    t.string  "webname",  limit: 255, null: false
  end

  add_index "manufacturer", ["name"], name: "manufacturer_name_key", unique: true, using: :btree
  add_index "manufacturer", ["webname"], name: "manufacturer_webname_key", unique: true, using: :btree

  create_table "medical_benefit_comparison_reports", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "provider_id"
    t.integer  "health_plan_type_aggregate_id"
    t.integer  "restriction_report_id"
    t.string   "drug_ids",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_benefit_coverage_reports", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "provider_id"
    t.integer  "health_plan_type_aggregate_id"
    t.integer  "restriction_report_id"
    t.integer  "drug_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_benefit_criteria_report_counties", force: :cascade do |t|
    t.integer  "criteria_report_id"
    t.integer  "county_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_benefit_criteria_report_drugs", force: :cascade do |t|
    t.integer  "criteria_report_id"
    t.integer  "drug_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_benefit_criteria_report_health_plan_types", force: :cascade do |t|
    t.integer  "criteria_report_id"
    t.integer  "health_plan_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_benefit_criteria_report_msas", force: :cascade do |t|
    t.integer  "criteria_report_id"
    t.integer  "msa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_benefit_criteria_report_restriction_report_criteria", force: :cascade do |t|
    t.integer  "criteria_report_id"
    t.integer  "restriction_report_criteria_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_benefit_criteria_report_states", force: :cascade do |t|
    t.integer  "criteria_report_id"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_benefit_criteria_reports", force: :cascade do |t|
    t.integer  "restriction_report_id"
    t.integer  "geography"
    t.integer  "display_by"
    t.string   "state",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_benefit_health_plan_type_categories", force: :cascade do |t|
    t.integer  "health_plan_type_group_id"
    t.integer  "design_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "medical_benefit_medical_policies", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "restriction_report_id"
    t.string   "policy_url",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                                    default: true
    t.integer  "health_plan_type_aggregate_id"
  end

  create_table "medical_benefit_restriction_comments", force: :cascade do |t|
    t.integer "restriction_report_id",             null: false
    t.integer "provider_id",                       null: false
    t.string  "health_plan_type",      limit: 255, null: false
    t.text    "content"
  end

  create_table "medical_benefit_restrictions", force: :cascade do |t|
    t.integer  "restriction_report_id"
    t.integer  "provider_id"
    t.string   "health_plan_type",       limit: 255
    t.integer  "drug_id"
    t.text     "clinical_criteria"
    t.text     "acquisition_guidelines"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medical_benefit_restrictions", ["drug_id"], name: "medical_benefit_restrictions_drug_id_index", using: :btree
  add_index "medical_benefit_restrictions", ["health_plan_type"], name: "medical_benefit_restrictions_health_plan_type_ind", using: :btree
  add_index "medical_benefit_restrictions", ["provider_id"], name: "medical_benefit_restrictions_provider_id_index", using: :btree
  add_index "medical_benefit_restrictions", ["restriction_report_id"], name: "medical_benefit_restrictions_restriction_report_id_index", using: :btree

  create_table "medical_benefit_sites", force: :cascade do |t|
    t.integer  "restriction_report_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medicare_lis_plan_lives_import", id: false, force: :cascade do |t|
    t.string  "contract_name", limit: 100
    t.string  "contract_id",   limit: 10
    t.string  "plan_id",       limit: 10
    t.string  "plan_name",     limit: 100
    t.integer "enrolled"
  end

  create_table "medicare_low_income_subsidy_lives", force: :cascade do |t|
    t.integer "health_plan_id",                       null: false
    t.integer "county_id",                            null: false
    t.integer "state_id",                             null: false
    t.integer "msa_id"
    t.decimal "lives"
    t.decimal "lives_original_value"
    t.boolean "lives_adjusted",       default: false
  end

  add_index "medicare_low_income_subsidy_lives", ["county_id"], name: "medicare_low_income_subsidy_lives_county_id_idx", using: :btree
  add_index "medicare_low_income_subsidy_lives", ["health_plan_id", "county_id"], name: "medicare_low_income_subsidy_lives_health_plan_id_county_id_idx", unique: true, using: :btree
  add_index "medicare_low_income_subsidy_lives", ["health_plan_id"], name: "medicare_low_income_subsidy_lives_health_plan_id_idx", using: :btree
  add_index "medicare_low_income_subsidy_lives", ["msa_id"], name: "medicare_low_income_subsidy_lives_msa_id_idx", using: :btree
  add_index "medicare_low_income_subsidy_lives", ["state_id"], name: "medicare_low_income_subsidy_lives_state_id_idx", using: :btree

  create_table "medicare_low_income_subsidy_lives_import", force: :cascade do |t|
    t.string  "fipsst",                     limit: 2
    t.string  "fipscnty",                   limit: 3
    t.string  "contract_id",                limit: 5
    t.string  "enrolled",                   limit: 20
    t.integer "full_fips_id"
    t.integer "county_id"
    t.string  "health_plan_id_mapped_list", limit: 200
    t.integer "state_id"
    t.integer "msa_id"
    t.boolean "is_imported",                            default: false, null: false
  end

  create_table "medicare_low_income_subsidy_lives_staging", force: :cascade do |t|
    t.integer "health_plan_id",       null: false
    t.integer "county_id",            null: false
    t.integer "state_id",             null: false
    t.integer "msa_id"
    t.decimal "lives"
    t.decimal "lives_original_value"
  end

  create_table "medicare_sn_allocate", force: :cascade do |t|
    t.integer  "sn_allocation", null: false
    t.integer  "ma_allocation", null: false
    t.datetime "created_at",    null: false
    t.integer  "created_by",    null: false
    t.datetime "modified_at",   null: false
    t.integer  "modified_by",   null: false
  end

  create_table "medicarelives_cms_data", force: :cascade do |t|
    t.string   "contract_id",  limit: 20,                null: false
    t.integer  "cms_plan_id",                            null: false
    t.integer  "state_id",                               null: false
    t.integer  "fips_id",                                null: false
    t.integer  "lives",                                  null: false
    t.integer  "import_month",                           null: false
    t.integer  "import_year",                            null: false
    t.datetime "created_at",                             null: false
    t.boolean  "active",                  default: true, null: false
  end

  add_index "medicarelives_cms_data", ["cms_plan_id"], name: "cms_data_cms_plan_id", using: :btree
  add_index "medicarelives_cms_data", ["contract_id"], name: "cms_data_contract_id", using: :btree
  add_index "medicarelives_cms_data", ["fips_id"], name: "cms_data_fips_id", using: :btree
  add_index "medicarelives_cms_data", ["import_month"], name: "import_month_idx", using: :btree
  add_index "medicarelives_cms_data", ["import_year"], name: "import_year_idx", using: :btree

  create_table "medicarelives_cms_enrollment", force: :cascade do |t|
    t.string   "contract_id",          limit: 20,                                         null: false
    t.integer  "part_d_enrollment",                                                       null: false
    t.integer  "total_enrollment",                                                        null: false
    t.decimal  "percent_d_enrollment",            precision: 10, scale: 4,                null: false
    t.integer  "import_month",                                                            null: false
    t.integer  "import_year",                                                             null: false
    t.datetime "created_at",                                                              null: false
    t.boolean  "active",                                                   default: true, null: false
  end

  add_index "medicarelives_cms_enrollment", ["contract_id"], name: "cms_enroll_contract_id", using: :btree
  add_index "medicarelives_cms_enrollment", ["import_month"], name: "medicarelives_cms_enrollment_import_month_idx", using: :btree
  add_index "medicarelives_cms_enrollment", ["import_year"], name: "medicarelives_cms_enrollment_import_year_idx", using: :btree

  create_table "medicarelives_cms_mapping", force: :cascade do |t|
    t.string   "contract_id",   limit: 20,                null: false
    t.integer  "cms_plan_id",                             null: false
    t.integer  "healthplan_id",                           null: false
    t.integer  "import_month",                            null: false
    t.integer  "import_year",                             null: false
    t.datetime "created_at",                              null: false
    t.boolean  "active",                   default: true, null: false
  end

  add_index "medicarelives_cms_mapping", ["cms_plan_id"], name: "cms_plan_id", using: :btree
  add_index "medicarelives_cms_mapping", ["contract_id"], name: "contract_id", using: :btree
  add_index "medicarelives_cms_mapping", ["healthplan_id"], name: "healthplan_id", using: :btree

  create_table "medicarelives_data", id: :bigserial, force: :cascade do |t|
    t.string   "import_id",          limit: 50,                   null: false
    t.string   "type",               limit: 10
    t.string   "contract_id",        limit: 20,                   null: false
    t.integer  "state_id",                                        null: false
    t.string   "state_abbreviation", limit: 2
    t.integer  "lives",                                           null: false
    t.integer  "import_year",                                     null: false
    t.integer  "import_month",                                    null: false
    t.datetime "created",                       default: "now()"
    t.integer  "active",                        default: 1
  end

  create_table "medicarelives_imports", id: :bigserial, force: :cascade do |t|
    t.string   "import_id",    limit: 50,                    null: false
    t.string   "notes",        limit: 500
    t.integer  "import_year",                                null: false
    t.integer  "import_month",                               null: false
    t.integer  "user_id",                  default: 0
    t.datetime "created",                  default: "now()"
    t.integer  "active",                   default: 1
  end

  add_index "medicarelives_imports", ["import_id"], name: "medicarelives_imports_healthplan_idx", using: :btree

  create_table "medicarelives_mappings", id: :bigserial, force: :cascade do |t|
    t.string   "import_id",     limit: 50,                   null: false
    t.integer  "healthplan_id",                              null: false
    t.string   "contract_id",   limit: 20,                   null: false
    t.string   "type",          limit: 10
    t.integer  "import_year",                                null: false
    t.integer  "import_month",                               null: false
    t.datetime "created",                  default: "now()"
    t.datetime "modified"
    t.integer  "active",                   default: 1
  end

  create_table "medicarelives_staging", id: :bigserial, force: :cascade do |t|
    t.string   "import_id",      limit: 50,                   null: false
    t.string   "contract_id",    limit: 20,                   null: false
    t.integer  "healthplan_id",                               null: false
    t.integer  "state_id",                                    null: false
    t.integer  "contract_lives",                              null: false
    t.integer  "contract_plans",                              null: false
    t.integer  "lives",                                       null: false
    t.integer  "import_year",                                 null: false
    t.integer  "import_month",                                null: false
    t.datetime "created",                   default: "now()"
    t.integer  "active",                    default: 1
  end

  create_table "merck_admin_plan_name_logs", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "health_plan_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merck_admin_plan_name_notes", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "health_plan_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merck_end_user_agreement_log", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "formulary_table_id"
    t.boolean  "agreement_accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merck_end_user_agreement_log", ["formulary_table_id"], name: "index_merck_end_user_agreement_log_on_formulary_table_id", using: :btree
  add_index "merck_end_user_agreement_log", ["user_id"], name: "index_merck_end_user_agreement_log_on_user_id", using: :btree

  create_table "merck_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2010-02-03 17:29:29'
    t.datetime "updated_at",                              default: '2010-02-03 17:29:29'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
    t.integer  "msa_id"
    t.integer  "county_id"
    t.integer  "analytics_header_type"
    t.string   "additional_pages",            limit: 255
    t.string   "municipal_plans_order_list",  limit: 255
    t.string   "mandatory_plans_list",        limit: 255
    t.integer  "max_competitor_drug_count"
    t.integer  "min_competitor_drug_count"
    t.string   "template_options",            limit: 255
    t.string   "plans_order_list",            limit: 255
  end

  add_index "merck_formularies", ["drug_class_id"], name: "merck_formularies_drug_class_id_idx", using: :btree
  add_index "merck_formularies", ["site_user_id"], name: "merck_formularies_site_user_id_idx", using: :btree
  add_index "merck_formularies", ["state_id"], name: "merck_formularies_state_id_idx", using: :btree
  add_index "merck_formularies", ["template"], name: "merck_formularies_template_idx", using: :btree

  create_table "merck_msa_names", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.integer  "msa_id",                 null: false
    t.string   "name",       limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merck_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "formulary_table_name", limit: 255
    t.integer  "formulary_table_id"
    t.string   "environment",          limit: 255
    t.string   "file_name",            limit: 255
    t.string   "pdf_unique_id",        limit: 255
  end

  create_table "merck_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "merck_plan_drug_options", ["created_by"], name: "merck_plan_drug_options_created_by_idx", using: :btree
  add_index "merck_plan_drug_options", ["updated_by"], name: "merck_plan_drug_options_updated_by_idx", using: :btree

  create_table "merck_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "merck_plan_drug_settings", ["created_by"], name: "merck_plan_drug_settings_created_by_idx", using: :btree
  add_index "merck_plan_drug_settings", ["drug_id"], name: "merck_plan_drug_settings_drug_id_idx", using: :btree
  add_index "merck_plan_drug_settings", ["healthplan_id"], name: "merck_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "merck_plan_drug_settings", ["plan_drug_option_id"], name: "merck_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "merck_plan_drug_settings", ["state_id"], name: "merck_plan_drug_settings_state_id_idx", using: :btree
  add_index "merck_plan_drug_settings", ["updated_by"], name: "merck_plan_drug_settings_updated_by_idx", using: :btree

  create_table "merck_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merck_plan_exclusions", ["health_plan_id", "active"], name: "merck_plan_exclusions_health_plan_id_active_idx", using: :btree
  add_index "merck_plan_exclusions", ["health_plan_id", "state_id"], name: "merck_plan_exclusions_health_plan_id_state_id_idx", using: :btree
  add_index "merck_plan_exclusions", ["health_plan_id"], name: "merck_plan_exclusions_health_plan_id_idx", using: :btree
  add_index "merck_plan_exclusions", ["state_id"], name: "merck_plan_exclusions_state_id_idx", using: :btree

  create_table "merck_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merck_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "merck_restrictions_criteria_customizations", force: :cascade do |t|
    t.integer  "restrictions_report_id"
    t.integer  "restrictions_report_criteria_id"
    t.string   "custom_label",                    limit: 255
    t.boolean  "is_excluded"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merck_roles", force: :cascade do |t|
    t.string   "role",                limit: 200
    t.string   "description",         limit: 200
    t.integer  "adminonly",                       default: 0
    t.integer  "requires_approval",               default: 0
    t.integer  "formulary_tables",                default: 0
    t.integer  "analytics",                       default: 0
    t.integer  "active",                          default: 1
    t.datetime "created_at",                      default: '2010-02-03 17:29:29'
    t.datetime "updated_at",                      default: '2010-02-03 17:29:29'
    t.integer  "accounts",                        default: 0,                     null: false
    t.integer  "restrictions",                    default: 0,                     null: false
    t.boolean  "is_super_user",                   default: false,                 null: false
    t.boolean  "publisher_reporting",             default: false
  end

  create_table "merck_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "merck_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-02-03 17:29:29'
    t.datetime "last_accessed_timestamp",             default: '2010-02-03 17:29:29'
  end

  create_table "merck_users", force: :cascade do |t|
    t.string   "login",                 limit: 255
    t.string   "email",                 limit: 255
    t.string   "password",              limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",            limit: 200
    t.string   "last_name",             limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                            default: 0
    t.integer  "approved",                          default: 0
    t.string   "activationkey",         limit: 50
    t.datetime "last_roster_update_at"
    t.string   "network_id",            limit: 255
  end

  create_table "merck_wk_drug_state_approval_rates", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "drug_id"
    t.string   "template_ids",  limit: 255
    t.decimal  "approval_rate",             precision: 11, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merck_wk_drug_state_copays", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "drug_id"
    t.string   "template_ids", limit: 255
    t.decimal  "copay_value",              precision: 12, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merckrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "merckuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "merckuser", ["email"], name: "merckuser_email_key", unique: true, using: :btree

  create_table "merckusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "metrostatarea", force: :cascade do |t|
    t.string  "name",            limit: 200, null: false
    t.integer "cbsa"
    t.integer "population"
    t.string  "ff_name",         limit: 100
    t.string  "image_file_name", limit: 255
  end

  add_index "metrostatarea", ["cbsa"], name: "metrostatarea_cbsa_idx", unique: true, using: :btree

  create_table "mobile_app_versions", force: :cascade do |t|
    t.string   "version_token",  limit: 255
    t.datetime "released_at"
    t.string   "description",    limit: 255
    t.string   "api_version",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allowed_access",             default: true
  end

  create_table "mobile_app_web_service_logs", force: :cascade do |t|
    t.string   "application_key", limit: 255
    t.string   "session_key",     limit: 255
    t.integer  "user_id"
    t.string   "controller",      limit: 255
    t.string   "action",          limit: 255
    t.string   "ip_address",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "udid",            limit: 255
  end

  create_table "mobile_ff_user_sessions", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "session_key",             limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp"
    t.datetime "last_accessed_timestamp"
  end

  create_table "msa", force: :cascade do |t|
    t.string   "site",        limit: 25,                    null: false
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 100
    t.datetime "modified",                default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "msahealthplan", force: :cascade do |t|
    t.integer  "msafid",                          null: false
    t.integer  "healthplanfid",                   null: false
    t.integer  "statefid",                        null: false
    t.datetime "modified",      default: "now()", null: false
    t.integer  "active",        default: 1,       null: false
  end

  create_table "msalives_archive", force: :cascade do |t|
    t.boolean  "on_hold",         default: false
    t.datetime "modifytimestamp",                 null: false
    t.integer  "modifyuser",                      null: false
  end

  create_table "msalives_mapping", force: :cascade do |t|
    t.integer "providerfid"
    t.integer "statefid",                      null: false
    t.string  "providername_file", limit: 100
    t.integer "importtypefid",                 null: false
  end

  create_table "msalives_medicare_data", id: :bigserial, force: :cascade do |t|
    t.string   "import_id",          limit: 50,                   null: false
    t.string   "type",               limit: 10
    t.string   "contract_id",        limit: 20,                   null: false
    t.integer  "state_id",                                        null: false
    t.integer  "fips_id",                                         null: false
    t.string   "state_abbreviation", limit: 2
    t.integer  "lives",                                           null: false
    t.integer  "import_year",                                     null: false
    t.integer  "import_month",                                    null: false
    t.datetime "created",                       default: "now()"
    t.integer  "active",                        default: 1
  end

  add_index "msalives_medicare_data", ["contract_id"], name: "msalives_medicare_data_contract_idx", using: :btree
  add_index "msalives_medicare_data", ["fips_id"], name: "msalives_medicare_data_fips_idx", using: :btree
  add_index "msalives_medicare_data", ["import_month"], name: "msalives_medicare_data_month_idx", using: :btree
  add_index "msalives_medicare_data", ["import_year"], name: "msalives_medicare_data_year_idx", using: :btree
  add_index "msalives_medicare_data", ["state_abbreviation"], name: "msalives_medicare_data_state_abbreviation_idx", using: :btree
  add_index "msalives_medicare_data", ["state_id"], name: "msalives_medicare_data_state_idx", using: :btree
  add_index "msalives_medicare_data", ["type"], name: "msalives_medicare_data_type_idx", using: :btree

  create_table "msalives_medicare_data_staging", force: :cascade do |t|
    t.string   "import_id",     limit: 50,                   null: false
    t.string   "contract_id",   limit: 50,                   null: false
    t.integer  "healthplan_id",                              null: false
    t.integer  "county_id",                                  null: false
    t.decimal  "lives",                                      null: false
    t.string   "data_type",     limit: 3,                    null: false
    t.integer  "import_year",                                null: false
    t.integer  "import_month",                               null: false
    t.datetime "created",                  default: "now()", null: false
    t.integer  "active",                   default: 1
  end

  add_index "msalives_medicare_data_staging", ["contract_id"], name: "msalives_medicare_data_staging_contract_idx", using: :btree
  add_index "msalives_medicare_data_staging", ["county_id"], name: "msalives_medicare_data_staging_county_idx", using: :btree
  add_index "msalives_medicare_data_staging", ["healthplan_id"], name: "msalives_medicare_data_staging_healthplan_idx", using: :btree
  add_index "msalives_medicare_data_staging", ["import_month"], name: "msalives_medicare_data_staging_import_month_idx", using: :btree
  add_index "msalives_medicare_data_staging", ["import_year"], name: "msalives_medicare_data_staging_import_year_idx", using: :btree

  create_table "msalives_medicare_imports", id: :bigserial, force: :cascade do |t|
    t.string   "import_id",    limit: 50,                    null: false
    t.string   "notes",        limit: 500
    t.integer  "import_year",                                null: false
    t.integer  "import_month",                               null: false
    t.integer  "user_id",                  default: 0
    t.datetime "created",                  default: "now()"
    t.integer  "active",                   default: 1
  end

  add_index "msalives_medicare_imports", ["import_id"], name: "msalives_medicare_imports_healthplan_idx", using: :btree

  create_table "msalives_medicare_mappings", id: :bigserial, force: :cascade do |t|
    t.string   "import_id",     limit: 50,                   null: false
    t.integer  "healthplan_id",                              null: false
    t.string   "contract_id",   limit: 20,                   null: false
    t.string   "type",          limit: 10
    t.integer  "import_year",                                null: false
    t.integer  "import_month",                               null: false
    t.datetime "created",                  default: "now()"
    t.datetime "modified"
    t.integer  "active",                   default: 1
  end

  add_index "msalives_medicare_mappings", ["contract_id"], name: "msalives_medicare_mappings_contract_idx", using: :btree
  add_index "msalives_medicare_mappings", ["healthplan_id"], name: "msalives_medicare_mappings_healthplan_idx", using: :btree
  add_index "msalives_medicare_mappings", ["import_month"], name: "msalives_medicare_mappings_month_idx", using: :btree
  add_index "msalives_medicare_mappings", ["import_year"], name: "msalives_medicare_mappings_year_idx", using: :btree
  add_index "msalives_medicare_mappings", ["type"], name: "msalives_medicare_mappings_type_idx", using: :btree

  create_table "msalives_medicare_sn_data", force: :cascade do |t|
    t.string   "import_id",    limit: 50,                   null: false
    t.string   "contract_id",  limit: 50,                   null: false
    t.integer  "lives",                                     null: false
    t.integer  "import_year",                               null: false
    t.integer  "import_month",                              null: false
    t.datetime "created",                 default: "now()", null: false
    t.integer  "active",                  default: 1
  end

  add_index "msalives_medicare_sn_data", ["contract_id"], name: "msalives_medicare_sn_data_contract_id_idx", using: :btree
  add_index "msalives_medicare_sn_data", ["import_month"], name: "msalives_medicare_sn_data_import_month_idx", using: :btree
  add_index "msalives_medicare_sn_data", ["import_year"], name: "msalives_medicare_sn_data_import_year_idx", using: :btree

  create_table "msalives_operations_tracking", force: :cascade do |t|
    t.integer  "healthplanfid",                               null: false
    t.integer  "statefid",                                    null: false
    t.integer  "countyfid",                                   null: false
    t.integer  "lives",                                       null: false
    t.string   "status",        limit: 10,                    null: false
    t.string   "notes",         limit: 100
    t.datetime "created",                   default: "now()", null: false
    t.integer  "created_by",                                  null: false
    t.datetime "modified",                  default: "now()", null: false
    t.integer  "modified_by",                                 null: false
  end

  add_index "msalives_operations_tracking", ["countyfid"], name: "msalives_operations_tracking_countyfidx", using: :btree
  add_index "msalives_operations_tracking", ["healthplanfid"], name: "msalives_operations_tracking_healthplanfidx", using: :btree
  add_index "msalives_operations_tracking", ["statefid"], name: "msalives_operations_tracking_statefidx", using: :btree
  add_index "msalives_operations_tracking", ["status"], name: "msalives_operations_tracking_statusx", using: :btree

  create_table "msalives_state_setting", force: :cascade do |t|
    t.integer "statefid",                      null: false
    t.integer "stateload",      default: 0,    null: false
    t.boolean "netoutmedicare", default: true, null: false
  end

  create_table "msastate", force: :cascade do |t|
    t.integer  "msafid",                     null: false
    t.integer  "statefid",                   null: false
    t.datetime "modified", default: "now()", null: false
    t.integer  "active",   default: 1,       null: false
  end

  create_table "mv_active_formularies", id: false, force: :cascade do |t|
    t.integer "formulary_id"
    t.integer "drug_id"
    t.integer "tier_id"
    t.boolean "has_quantity_limit"
    t.boolean "has_prior_authorization"
    t.boolean "has_step_therapy"
    t.boolean "has_other_restriction"
    t.integer "reason_code_id"
  end

  add_index "mv_active_formularies", ["drug_id"], name: "mv_drug_id_idx", using: :btree
  add_index "mv_active_formularies", ["formulary_id"], name: "mv_formulary_id_idx", using: :btree
  add_index "mv_active_formularies", ["tier_id"], name: "mv_tier_id_idx", using: :btree

  create_table "mv_hpl_countyfid", id: false, force: :cascade do |t|
    t.integer "healthplanfid"
    t.integer "countyfid"
    t.decimal "lives"
  end

  add_index "mv_hpl_countyfid", ["countyfid"], name: "mv_hpl_countyfid_idx", using: :btree
  add_index "mv_hpl_countyfid", ["healthplanfid"], name: "mv_hpl_county_hpl_idx", using: :btree

  create_table "mv_hpl_metrostatareafid", id: false, force: :cascade do |t|
    t.integer "healthplanfid"
    t.integer "metrostatareafid"
    t.decimal "lives"
  end

  add_index "mv_hpl_metrostatareafid", ["healthplanfid"], name: "mv_hpl_metro_hpl_idx", using: :btree
  add_index "mv_hpl_metrostatareafid", ["metrostatareafid"], name: "mv_hpl_metrostatareafid_idx", using: :btree

  create_table "mv_medicarelives_cms_data_counts", id: false, force: :cascade do |t|
    t.integer "import_month"
    t.integer "import_year"
    t.string  "contract_id",  limit: 20
    t.integer "fips_id"
    t.integer "cms_plan_id"
    t.integer "row_count",    limit: 8
  end

  add_index "mv_medicarelives_cms_data_counts", ["cms_plan_id"], name: "mv_mcdc_cms_plan_id_idx", using: :btree
  add_index "mv_medicarelives_cms_data_counts", ["contract_id"], name: "mv_mcdc_contract_id_idx", using: :btree
  add_index "mv_medicarelives_cms_data_counts", ["fips_id"], name: "mv_mcdc_fips_id_idx", using: :btree
  add_index "mv_medicarelives_cms_data_counts", ["import_month", "import_year", "contract_id", "fips_id", "cms_plan_id"], name: "mv_mcdc_combined_idx", using: :btree
  add_index "mv_medicarelives_cms_data_counts", ["import_month"], name: "mv_mcdc_import_month_idx", using: :btree
  add_index "mv_medicarelives_cms_data_counts", ["import_year"], name: "mv_mcdc_import_year_idx", using: :btree

  create_table "mview_hpl3", id: false, force: :cascade do |t|
    t.integer "countyfid"
    t.integer "id"
    t.integer "healthplantypefid"
    t.decimal "total"
  end

  add_index "mview_hpl3", ["healthplantypefid"], name: "mview_hpq_idx", using: :btree
  add_index "mview_hpl3", ["id"], name: "mview_hpq1_idx", using: :btree

  create_table "mview_state_pps", id: false, force: :cascade do |t|
    t.integer "drugfid"
    t.integer "healthplantypefid"
    t.integer "statefid"
    t.integer "id"
  end

  add_index "mview_state_pps", ["drugfid", "healthplantypefid", "statefid"], name: "mview_5_idx", using: :btree

  create_table "nationallives_batch", force: :cascade do |t|
    t.integer  "providerfid",     null: false
    t.integer  "lives",           null: false
    t.datetime "modifytimestamp", null: false
  end

  create_table "nexiumoccupation", force: :cascade do |t|
    t.string  "name",     limit: 200,                null: false
    t.boolean "isactive",             default: true, null: false
  end

  create_table "nexiumstats", force: :cascade do |t|
    t.integer  "nexiumuserfid"
    t.integer  "drugfid"
    t.integer  "healthplanfid"
    t.integer  "formularyview"
    t.datetime "createtimestamp", null: false
    t.date     "viewmonth",       null: false
  end

  create_table "nexiumuser", force: :cascade do |t|
    t.string   "email",              limit: 200,                null: false
    t.string   "password",           limit: 200,                null: false
    t.string   "firstname",          limit: 200,                null: false
    t.string   "lastname",           limit: 200,                null: false
    t.integer  "occupationfid"
    t.string   "occupationother",    limit: 200
    t.datetime "createtimestamp",                               null: false
    t.datetime "modifytimestamp",                               null: false
    t.boolean  "isactive",                       default: true, null: false
    t.integer  "isemailupdates",                 default: 0,    null: false
    t.integer  "isotherupdates",                 default: 0,    null: false
    t.integer  "isnexiumupdates",                default: 0,    null: false
    t.integer  "iscrestorupdates",               default: 0,    null: false
    t.integer  "isseroquelupdates",              default: 0,    null: false
    t.integer  "issymbicortupdates",             default: 0,    null: false
  end

  create_table "nexiumuserhealthplan", force: :cascade do |t|
    t.integer  "nexiumuserfid",   null: false
    t.integer  "healthplanfid",   null: false
    t.datetime "createtimestamp", null: false
  end

  create_table "nexiumusersession", force: :cascade do |t|
    t.integer  "nexiumuserfid",                     null: false
    t.string   "sessionid",             limit: 200, null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                    null: false
    t.datetime "lastaccessedtimestamp",             null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "type",                                     null: false
    t.text     "note",                                     null: false
    t.datetime "created",                default: "now()", null: false
    t.datetime "modified",                                 null: false
    t.string   "modifiedby", limit: 100
    t.integer  "active",                 default: 1,       null: false
  end

  create_table "notestypes", force: :cascade do |t|
    t.string  "tablename",   limit: 100,             null: false
    t.string  "type",        limit: 50,              null: false
    t.string  "description", limit: 100
    t.integer "active",                  default: 1, null: false
  end

  create_table "novartis_formularies", force: :cascade do |t|
    t.integer  "active",                                           default: 1
    t.integer  "published",                                        default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                                       default: '2008-10-13 09:13:45'
    t.datetime "updated_at",                                       default: '2008-10-13 09:13:45'
    t.datetime "published_at"
    t.string   "title",                                limit: 100
    t.string   "version",                              limit: 100
    t.integer  "version_number",                                   default: 0
    t.string   "template",                             limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",                      limit: 255
    t.string   "spotlight_drug_list",                  limit: 255
    t.string   "additional_site_drug_list",            limit: 255
    t.string   "competitor_drug_list",                 limit: 255
    t.string   "plan_type_order_list",                 limit: 255
    t.string   "preferred_provider_list",              limit: 255
    t.string   "commercial_provider_order_list",       limit: 255
    t.string   "medicare_provider_order_list",         limit: 255
    t.string   "medicaid_provider_order_list",         limit: 255
    t.string   "new_provider_list",                    limit: 255
    t.string   "bold_provider_list",                   limit: 255
    t.boolean  "display_restrictions",                             default: false
    t.integer  "msa_id"
    t.string   "commercial_provider_list",             limit: 255
    t.string   "medicare_provider_list",               limit: 255
    t.string   "medicaid_provider_list",               limit: 255
    t.string   "companion_drug_list",                  limit: 255
    t.string   "graph_option",                         limit: 255
    t.string   "municipal_provider_order_list",        limit: 255
    t.string   "municipal_provider_list",              limit: 255
    t.string   "commercial_provider_highlighted_list", limit: 255
    t.string   "medicare_provider_highlighted_list",   limit: 255
    t.string   "medicaid_provider_highlighted_list",   limit: 255
    t.string   "municipal_provider_highlighted_list",  limit: 255
    t.string   "graph_region",                         limit: 255
    t.string   "line_extension_drug_id_list",          limit: 255
    t.boolean  "optional_banner"
    t.boolean  "optional_header"
    t.string   "template_options",                     limit: 255
    t.string   "second_template_option",               limit: 255
    t.integer  "second_state_id"
    t.integer  "second_msa_id"
    t.integer  "county_id"
  end

  create_table "novartis_formularies_old", force: :cascade do |t|
    t.integer  "active",                                           default: 1
    t.integer  "published",                                        default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                                       default: '2008-10-13 09:13:45'
    t.datetime "updated_at",                                       default: '2008-10-13 09:13:45'
    t.datetime "published_at"
    t.string   "title",                                limit: 100
    t.string   "version",                              limit: 100
    t.integer  "version_number",                                   default: 0
    t.string   "template",                             limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",                      limit: 255
    t.string   "spotlight_drug_list",                  limit: 255
    t.string   "additional_site_drug_list",            limit: 255
    t.string   "competitor_drug_list",                 limit: 255
    t.string   "plan_type_order_list",                 limit: 255
    t.string   "preferred_provider_list",              limit: 255
    t.string   "commercial_provider_order_list",       limit: 255
    t.string   "medicare_provider_order_list",         limit: 255
    t.string   "medicaid_provider_order_list",         limit: 255
    t.string   "new_provider_list",                    limit: 255
    t.string   "bold_provider_list",                   limit: 255
    t.boolean  "display_restrictions",                             default: false
    t.integer  "msa_id"
    t.string   "commercial_provider_list",             limit: 255
    t.string   "medicare_provider_list",               limit: 255
    t.string   "medicaid_provider_list",               limit: 255
    t.string   "companion_drug_list",                  limit: 255
    t.string   "graph_option",                         limit: 255
    t.string   "municipal_provider_order_list",        limit: 255
    t.string   "municipal_provider_list",              limit: 255
    t.string   "commercial_provider_highlighted_list", limit: 255
    t.string   "medicare_provider_highlighted_list",   limit: 255
    t.string   "medicaid_provider_highlighted_list",   limit: 255
    t.string   "municipal_provider_highlighted_list",  limit: 255
    t.string   "graph_region",                         limit: 255
    t.string   "line_extension_drug_id_list",          limit: 255
    t.boolean  "optional_banner"
    t.boolean  "optional_header"
    t.string   "template_options",                     limit: 255
    t.string   "second_template_option",               limit: 255
    t.integer  "second_state_id"
    t.integer  "second_msa_id"
    t.integer  "county_id"
  end

  add_index "novartis_formularies_old", ["drug_class_id"], name: "novartis_formularies_drug_class_id_idx", using: :btree
  add_index "novartis_formularies_old", ["site_user_id"], name: "novartis_formularies_site_user_id_idx", using: :btree
  add_index "novartis_formularies_old", ["state_id"], name: "novartis_formularies_state_id_idx", using: :btree
  add_index "novartis_formularies_old", ["template"], name: "novartis_formularies_template_idx", using: :btree

  create_table "novartis_formulary_table_provider_icons", force: :cascade do |t|
    t.integer  "publisher_formulary_id"
    t.integer  "provider_id"
    t.string   "icon",                   limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "novartis_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "formulary_table_name", limit: 255
    t.integer  "formulary_table_id"
    t.string   "environment",          limit: 255
    t.string   "file_name",            limit: 255
    t.string   "pdf_unique_id",        limit: 255
    t.string   "file_path",            limit: 255
  end

  create_table "novartis_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "novartis_preferred_provider_inclusions", force: :cascade do |t|
    t.boolean  "active",             default: true
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "novartis_provider_custom", force: :cascade do |t|
    t.integer  "provider_id"
    t.string   "name",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  add_index "novartis_provider_custom", ["provider_id"], name: "novartis_provider_custom_provider_id_uiq", unique: true, using: :btree

  create_table "novartis_provider_exclusions", force: :cascade do |t|
    t.boolean  "active",                   default: true
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
    t.integer  "publisher_template_id"
    t.integer  "ff_publisher_template_id"
  end

  create_table "novartis_provider_plans", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "healthplan_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
    t.integer  "custom_provider_id"
  end

  add_index "novartis_provider_plans", ["healthplan_id"], name: "novartis_provider_plans_healthplan_id_uiq", unique: true, using: :btree

  create_table "novartis_publisher_activity_report_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "novartis_publisher_activity_report_states", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "novartis_publisher_activity_report_templates", force: :cascade do |t|
    t.integer  "template_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "template_type",                limit: 255
  end

  create_table "novartis_publisher_activity_reports", force: :cascade do |t|
    t.boolean  "use_preset_date"
    t.string   "preset_date",     limit: 255
    t.date     "end_date"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "novartis_publisher_formularies", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.string   "current_step",                  limit: 255
    t.string   "name",                          limit: 255
    t.string   "spotlight_drug_ids",            limit: 255, default: ""
    t.string   "competitor_drug_ids",           limit: 255, default: ""
    t.string   "line_extension_drug_ids",       limit: 255, default: ""
    t.integer  "state_id"
    t.integer  "msa_id"
    t.string   "geographic_customization",      limit: 255
    t.string   "health_plan_types",             limit: 255, default: ""
    t.string   "preferred_provider_ids",        limit: 255, default: ""
    t.string   "commercial_provider_ids",       limit: 255, default: ""
    t.string   "medicare_provider_ids",         limit: 255, default: ""
    t.string   "medicaid_provider_ids",         limit: 255, default: ""
    t.string   "bolded_provider_ids",           limit: 255, default: ""
    t.string   "highlighted_provider_ids",      limit: 255, default: ""
    t.integer  "header_type"
    t.integer  "version"
    t.boolean  "is_active",                                 default: true
    t.boolean  "is_published",                              default: false
    t.integer  "created_by_id"
    t.boolean  "display_violator",                          default: false
    t.datetime "violator_date"
    t.boolean  "display_restrictions",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "legacy_novartis_formulary_id"
    t.string   "secondary_competitor_drug_ids", limit: 255
    t.string   "split_drugs",                   limit: 255, default: ""
    t.string   "custom_header_tier_status",     limit: 255, default: ""
    t.string   "custom_table_tier_status",      limit: 255, default: ""
    t.integer  "county_id"
    t.string   "pbm_provider_ids",              limit: 255, default: ""
    t.string   "violator_type",                 limit: 255
  end

  create_table "novartis_publisher_formularies_tmp", id: false, force: :cascade do |t|
    t.integer  "id",                                                        null: false
    t.integer  "publisher_template_id"
    t.string   "current_step",                  limit: 255
    t.string   "name",                          limit: 255
    t.string   "spotlight_drug_ids",            limit: 255, default: ""
    t.string   "competitor_drug_ids",           limit: 255, default: ""
    t.string   "line_extension_drug_ids",       limit: 255, default: ""
    t.integer  "state_id"
    t.integer  "msa_id"
    t.string   "geographic_customization",      limit: 255
    t.string   "health_plan_types",             limit: 255, default: ""
    t.string   "preferred_provider_ids",        limit: 255, default: ""
    t.string   "commercial_provider_ids",       limit: 255, default: ""
    t.string   "medicare_provider_ids",         limit: 255, default: ""
    t.string   "medicaid_provider_ids",         limit: 255, default: ""
    t.string   "bolded_provider_ids",           limit: 255, default: ""
    t.string   "highlighted_provider_ids",      limit: 255, default: ""
    t.integer  "header_type"
    t.integer  "version"
    t.boolean  "is_active",                                 default: true
    t.boolean  "is_published",                              default: false
    t.integer  "created_by_id"
    t.boolean  "display_violator",                          default: false
    t.datetime "violator_date"
    t.boolean  "display_restrictions",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "legacy_novartis_formulary_id"
    t.string   "secondary_competitor_drug_ids", limit: 255
    t.string   "split_drugs",                   limit: 255, default: ""
    t.string   "custom_header_tier_status",     limit: 255, default: ""
    t.string   "custom_table_tier_status",      limit: 255, default: ""
    t.integer  "county_id"
    t.string   "pbm_provider_ids",              limit: 255, default: ""
    t.string   "violator_type",                 limit: 255
  end

  create_table "novartis_publisher_templates", force: :cascade do |t|
    t.string   "name",                          limit: 255
    t.string   "klass_name",                    limit: 255
    t.string   "spotlight_drug_ids",            limit: 255, default: ""
    t.string   "competitor_drug_ids",           limit: 255, default: ""
    t.integer  "provider_count_min"
    t.integer  "provider_count_max"
    t.integer  "competitor_drug_count_min"
    t.integer  "competitor_drug_count_max"
    t.string   "allowed_role_ids",              limit: 255, default: ""
    t.boolean  "is_active",                                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "drug_ids_with_line_extensions", limit: 255
    t.integer  "drug_class_id"
  end

  create_table "novartis_roles", force: :cascade do |t|
    t.string   "role",                limit: 200
    t.string   "description",         limit: 200
    t.integer  "adminonly",                       default: 0
    t.integer  "requiresapproval",                default: 0
    t.integer  "createtable",                     default: 0
    t.integer  "analytics",                       default: 0
    t.integer  "active",                          default: 1
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
    t.integer  "formulary_tables"
    t.integer  "accounts",                        default: 0
    t.boolean  "can_expire",                      default: false
    t.boolean  "is_private",                      default: false
    t.boolean  "publisher_reporting",             default: false
  end

  create_table "novartis_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "novartis_users", force: :cascade do |t|
    t.string   "login",                     limit: 255
    t.string   "email",                     limit: 255
    t.string   "password",                  limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",                limit: 200
    t.string   "last_name",                 limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                                default: 0
    t.integer  "approved",                              default: 0
    t.integer  "alerts",                                default: 0
    t.string   "activationkey",             limit: 50
    t.datetime "expires_at"
    t.datetime "expiration_notice_sent_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "renewed_at"
  end

  create_table "novartisuseralert", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
  end

  create_table "novartisuserservice", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid",      null: false
    t.integer "drugclassfid"
  end

  create_table "novartisusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "novo_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2011-06-14 18:42:04'
    t.datetime "updated_at",                              default: '2011-06-14 18:42:04'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "novo_formularies", ["drug_class_id"], name: "novo_formularies_drug_class_id_idx", using: :btree
  add_index "novo_formularies", ["site_user_id"], name: "novo_formularies_site_user_id_idx", using: :btree
  add_index "novo_formularies", ["state_id"], name: "novo_formularies_state_id_idx", using: :btree
  add_index "novo_formularies", ["template"], name: "novo_formularies_template_idx", using: :btree

  create_table "novo_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "novo_plan_drug_options", ["created_by"], name: "novo_plan_drug_options_created_by_idx", using: :btree
  add_index "novo_plan_drug_options", ["updated_by"], name: "novo_plan_drug_options_updated_by_idx", using: :btree

  create_table "novo_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "novo_plan_drug_settings", ["created_by"], name: "novo_plan_drug_settings_created_by_idx", using: :btree
  add_index "novo_plan_drug_settings", ["drug_id"], name: "novo_plan_drug_settings_drug_id_idx", using: :btree
  add_index "novo_plan_drug_settings", ["healthplan_id"], name: "novo_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "novo_plan_drug_settings", ["plan_drug_option_id"], name: "novo_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "novo_plan_drug_settings", ["state_id"], name: "novo_plan_drug_settings_state_id_idx", using: :btree
  add_index "novo_plan_drug_settings", ["updated_by"], name: "novo_plan_drug_settings_updated_by_idx", using: :btree

  create_table "novo_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "novo_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "novo_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "novo_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "accounts",                      default: 0
    t.integer  "active",                        default: 1
    t.boolean  "is_super_user",                 default: false
    t.datetime "created_at",                    default: '2011-06-14 18:42:03'
    t.datetime "updated_at",                    default: '2011-06-14 18:42:03'
    t.integer  "alerts",                        default: 0,                     null: false
  end

  create_table "novo_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "novo_user_alerts", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.integer  "legacyfid"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "archived_at"
  end

  create_table "novo_user_services", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid"
    t.integer "drugclassfid"
  end

  create_table "novo_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2011-06-14 18:42:04'
    t.datetime "last_accessed_timestamp",             default: '2011-06-14 18:42:04'
  end

  create_table "novo_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
    t.boolean  "has_alerts",                default: false, null: false
  end

  create_table "opportunity_factor", force: :cascade do |t|
    t.integer "sitefid",      null: false
    t.integer "userfid",      null: false
    t.integer "typefid",      null: false
    t.decimal "factor_value", null: false
  end

  create_table "opportunity_factor_groups", force: :cascade do |t|
    t.string   "name",       limit: 255,                null: false
    t.integer  "sort_index",             default: 0,    null: false
    t.boolean  "active",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opportunity_factor_groups", ["name", "active"], name: "index_opportunity_factor_groups_on_name_and_active", using: :btree
  add_index "opportunity_factor_groups", ["name"], name: "index_opportunity_factor_groups_on_name", using: :btree

  create_table "opportunity_factor_type", force: :cascade do |t|
    t.string  "parameter",    limit: 100, null: false
    t.string  "description",  limit: 100, null: false
    t.decimal "factor_value",             null: false
    t.integer "orderid",                  null: false
  end

  create_table "opportunity_factor_types", force: :cascade do |t|
    t.integer  "opportunity_factor_group_id",                            null: false
    t.string   "description",                 limit: 255,                null: false
    t.float    "value",                                   default: 1.0,  null: false
    t.integer  "sort_index",                              default: 0,    null: false
    t.integer  "legacy_id"
    t.boolean  "active",                                  default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opportunity_factor_types", ["opportunity_factor_group_id", "active"], name: "index_opportunity_factor_types_on_opportunity_factor_group_id_a", using: :btree
  add_index "opportunity_factor_types", ["opportunity_factor_group_id"], name: "index_opportunity_factor_types_on_opportunity_factor_group_id", using: :btree

  create_table "opportunity_factor_values", force: :cascade do |t|
    t.integer  "opportunity_factor_type_id",                null: false
    t.integer  "ff_user_id",                                null: false
    t.integer  "site_id",                                   null: false
    t.float    "value",                                     null: false
    t.boolean  "active",                     default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "opportunity_factor_values", ["ff_user_id", "site_id", "active"], name: "index_opportunity_factor_values_on_ff_user_id_and_site_id_and_a", using: :btree
  add_index "opportunity_factor_values", ["ff_user_id", "site_id"], name: "index_opportunity_factor_values_on_ff_user_id_and_site_id", using: :btree
  add_index "opportunity_factor_values", ["ff_user_id"], name: "index_opportunity_factor_values_on_ff_user_id", using: :btree
  add_index "opportunity_factor_values", ["opportunity_factor_type_id", "active"], name: "index_opportunity_factor_values_on_opportunity_factor_type_id_a", using: :btree
  add_index "opportunity_factor_values", ["opportunity_factor_type_id"], name: "index_opportunity_factor_values_on_opportunity_factor_type_id", using: :btree

  create_table "order_quantity", force: :cascade do |t|
    t.integer "quantity",                 null: false
    t.string  "template_size", limit: 10
  end

  create_table "organondrugplanform", primary_key: "entityid", force: :cascade do |t|
    t.integer "formularyfid",               null: false
    t.integer "planid",                     null: false
    t.integer "drugid",                     null: false
    t.integer "coveragestatus",             null: false
    t.boolean "priorauth",                  null: false
    t.boolean "quantlimit",                 null: false
    t.boolean "stepther",                   null: false
    t.integer "resetflag",      default: 0, null: false
    t.integer "paforall",       default: 0, null: false
  end

  create_table "organonformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                   null: false
    t.integer  "statefid",                                  null: false
    t.integer  "drugclassfid",                              null: false
    t.string   "planlist",         limit: 1000,             null: false
    t.string   "druglist",         limit: 100,              null: false
    t.string   "tableversion",     limit: 100,              null: false
    t.string   "description",      limit: 100,              null: false
    t.integer  "versionnumber",                 default: 0, null: false
    t.integer  "ispublished",                   default: 0, null: false
    t.integer  "isexported",                    default: 0, null: false
    t.integer  "isactive",                      default: 1, null: false
    t.integer  "mostrecent",                    default: 0, null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "createtimestamp",                           null: false
    t.datetime "modifytimestamp",                           null: false
  end

  create_table "organonrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "organonuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "organonuser", ["email"], name: "organonuser_email_key", unique: true, using: :btree

  create_table "organonusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "otsuka_abilify_ordering_tool_orders", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                  limit: 255
    t.integer  "site_formulary_table_id"
    t.integer  "created_by_user_id"
    t.integer  "quantity"
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "address_line_1",          limit: 255
    t.string   "address_line_2",          limit: 255
    t.string   "city",                    limit: 255
    t.string   "state",                   limit: 255
    t.string   "zip_code",                limit: 255
    t.string   "telephone",               limit: 255
    t.string   "email",                   limit: 255
    t.integer  "searchable_order_id"
    t.string   "footer_code",             limit: 255
  end

  create_table "otsuka_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2011-01-12 15:47:07'
    t.datetime "updated_at",                              default: '2011-01-12 15:47:07'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
    t.integer  "custom_header_option"
    t.boolean  "include_state_percentage"
    t.boolean  "copied_to_sa",                            default: false
    t.integer  "sa_formulary_id"
    t.integer  "county_id"
    t.integer  "msa_id"
    t.string   "selected_health_plan_types",  limit: 255
    t.boolean  "display_tier_status",                     default: true
    t.boolean  "sent"
    t.boolean  "fromMobile"
    t.string   "to_email",                    limit: 255
  end

  add_index "otsuka_formularies", ["drug_class_id"], name: "otsuka_formularies_drug_class_id_idx", using: :btree
  add_index "otsuka_formularies", ["site_user_id"], name: "otsuka_formularies_site_user_id_idx", using: :btree
  add_index "otsuka_formularies", ["state_id"], name: "otsuka_formularies_state_id_idx", using: :btree
  add_index "otsuka_formularies", ["template"], name: "otsuka_formularies_template_idx", using: :btree

  create_table "otsuka_formulary_order_addresses", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "user_id"
    t.integer  "formulary_order_id"
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "address_1",          limit: 255
    t.string   "address_2",          limit: 255
    t.string   "city",               limit: 255
    t.integer  "state_id"
    t.string   "zip_code",           limit: 255
    t.string   "telephone_1",        limit: 255
    t.string   "telephone_2",        limit: 255
    t.string   "telephone_3",        limit: 255
    t.string   "telephone_4",        limit: 255
    t.string   "email",              limit: 255
    t.boolean  "store",                          default: false
  end

  create_table "otsuka_formulary_order_defaults", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",            default: "now()"
    t.datetime "updated_at",            default: "now()"
    t.integer  "publisher_template_id"
    t.integer  "role_id"
    t.integer  "max_quantity"
  end

  create_table "otsuka_formulary_orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "formulary_id"
    t.integer  "quantity"
    t.boolean  "special_dl",               default: false
    t.integer  "lock_version",             default: 0
    t.string   "pdf_file",     limit: 255,                   null: false
    t.boolean  "order_sent",               default: false,   null: false
    t.boolean  "order_ftp",                default: false,   null: false
    t.datetime "created_at",               default: "now()"
    t.datetime "updated_at",               default: "now()"
  end

  create_table "otsuka_formulary_table_options", force: :cascade do |t|
    t.integer  "formulary_table_id"
    t.integer  "accompanying_formulary_table_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "otsuka_mobile_request_logs", force: :cascade do |t|
    t.string   "udid",            limit: 255
    t.string   "os_version",      limit: 255
    t.string   "application_key", limit: 255
    t.string   "session_key",     limit: 255
    t.string   "device_model",    limit: 255
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "otsuka_mobile_request_logs", ["udid"], name: "index_otsuka_mobile_request_logs_on_udid", using: :btree

  create_table "otsuka_mobile_user_sessions", force: :cascade do |t|
    t.string   "session_key",      limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_accessed_at"
  end

  add_index "otsuka_mobile_user_sessions", ["session_key"], name: "index_otsuka_mobile_user_sessions_on_session_key", using: :btree
  add_index "otsuka_mobile_user_sessions", ["user_id"], name: "index_otsuka_mobile_user_sessions_on_user_id", using: :btree

  create_table "otsuka_msa_names", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",             default: "now()"
    t.datetime "updated_at",             default: "now()"
    t.integer  "msa_id"
    t.string   "name",       limit: 100
  end

  create_table "otsuka_ordering_tool_template_quantities", force: :cascade do |t|
    t.integer  "ff_publisher_template_id"
    t.integer  "site_role_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "otsuka_pdf_access_archive", force: :cascade do |t|
    t.datetime "created_at",                default: "now()"
    t.integer  "active",                    default: 1
    t.integer  "user_id"
    t.integer  "formulary_id"
    t.string   "access_method", limit: 255
    t.string   "file_path",     limit: 255
    t.string   "file_name",     limit: 255
  end

  create_table "otsuka_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "otsuka_plan_drug_options", ["created_by"], name: "otsuka_plan_drug_options_created_by_idx", using: :btree
  add_index "otsuka_plan_drug_options", ["updated_by"], name: "otsuka_plan_drug_options_updated_by_idx", using: :btree

  create_table "otsuka_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "user_id"
    t.datetime "created_at",    default: "now()"
    t.datetime "updated_at",    default: "now()"
    t.boolean  "exclude",       default: false
    t.boolean  "bold",          default: false
    t.boolean  "highlight",     default: false
  end

  add_index "otsuka_plan_drug_settings", ["drug_id"], name: "otsuka_plan_drug_settings_drug_id_idx", using: :btree
  add_index "otsuka_plan_drug_settings", ["healthplan_id"], name: "otsuka_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "otsuka_plan_drug_settings", ["state_id"], name: "otsuka_plan_drug_settings_state_id_idx", using: :btree
  add_index "otsuka_plan_drug_settings", ["user_id"], name: "otsuka_plan_drug_settings_site_user_id_idx", using: :btree

  create_table "otsuka_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "otsuka_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "otsuka_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "otsuka_provider_rollup", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "user_id"
    t.datetime "created_at",  default: "now()"
    t.datetime "updated_at",  default: "now()"
    t.boolean  "show_footer", default: true
  end

  create_table "otsuka_provider_rollup_footers", force: :cascade do |t|
    t.boolean  "active",      default: true
    t.integer  "provider_id"
    t.boolean  "show_footer", default: true
    t.datetime "created_at",  default: "now()"
    t.datetime "updated_at",  default: "now()"
    t.integer  "user_id"
  end

  create_table "otsuka_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.datetime "created_at",                    default: '2011-01-12 15:47:07'
    t.datetime "updated_at",                    default: '2011-01-12 15:47:07'
    t.boolean  "abilify_ordering",              default: false
    t.integer  "reporting",                     default: 0
    t.boolean  "super_user",                    default: false,                 null: false
    t.integer  "restrictions",                  default: 0
  end

  create_table "otsuka_site_user_available_order_quantities", force: :cascade do |t|
    t.integer "quantity"
    t.integer "site_user_id"
    t.integer "ff_publisher_template_id"
  end

  create_table "otsuka_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "otsuka_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2011-01-12 15:47:07'
    t.datetime "last_accessed_timestamp",             default: '2011-01-12 15:47:07'
  end

  create_table "otsuka_users", force: :cascade do |t|
    t.string   "login",          limit: 255
    t.string   "email",          limit: 255
    t.string   "password",       limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",     limit: 200
    t.string   "last_name",      limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                     default: 0
    t.integer  "approved",                   default: 0
    t.string   "activationkey",  limit: 50
    t.string   "client_user_id", limit: 255
  end

  create_table "parents", force: :cascade do |t|
    t.string   "name",               limit: 200,                null: false
    t.boolean  "isactive",                       default: true, null: false
    t.datetime "lastupdate",                                    null: false
    t.integer  "lastupdateffuserid",                            null: false
  end

  create_table "pbm", force: :cascade do |t|
    t.boolean "isactive",               null: false
    t.string  "name",       limit: 255, null: false
    t.string  "webname",    limit: 255, null: false
    t.string  "corp_owner", limit: 100
    t.string  "address1",   limit: 100
    t.string  "address2",   limit: 100
    t.string  "city",       limit: 50
    t.integer "statefid"
    t.string  "zip",        limit: 10
    t.string  "phone",      limit: 50
    t.string  "fax",        limit: 50
    t.string  "website",    limit: 500
  end

  add_index "pbm", ["name"], name: "pbm_name_key", unique: true, using: :btree
  add_index "pbm", ["webname"], name: "pbm_webname_key", unique: true, using: :btree

  create_table "pbm_healthplan_pharmacy", id: false, force: :cascade do |t|
    t.integer  "healthplanid_fk",                   null: false
    t.integer  "pharmacyid_fk",                     null: false
    t.date     "last_update"
    t.date     "effective_date"
    t.integer  "creatorid_fk"
    t.datetime "create_stamp",    default: "now()"
    t.integer  "modbyid_fk"
    t.datetime "mod_stamp"
    t.integer  "active",          default: 1,       null: false
  end

  create_table "pbm_healthplan_pharmacy_temp", id: false, force: :cascade do |t|
    t.integer  "healthplanid_fk"
    t.integer  "pharmacyid_fk"
    t.date     "last_update"
    t.date     "effective_date"
    t.integer  "creatorid_fk"
    t.datetime "create_stamp"
    t.integer  "modbyid_fk"
    t.datetime "mod_stamp"
    t.integer  "active"
  end

  create_table "pbm_specialty_pharmacy", force: :cascade do |t|
    t.integer  "active",                   default: 1,       null: false
    t.string   "name",         limit: 100
    t.string   "corp_owner",   limit: 100
    t.string   "address1",     limit: 100
    t.string   "address2",     limit: 100
    t.string   "city",         limit: 50
    t.integer  "state_fk"
    t.string   "zip",          limit: 10
    t.string   "phone1",       limit: 20
    t.string   "fax",          limit: 20
    t.string   "email",        limit: 100
    t.string   "url_main",     limit: 500
    t.integer  "creatorid_fk"
    t.datetime "create_stamp",             default: "now()"
    t.integer  "modbyid_fk"
    t.datetime "mod_stamp"
  end

  add_index "pbm_specialty_pharmacy", ["name"], name: "pbm_pharmacy_name_idx", using: :btree

  create_table "pbm_specialty_pharmacy_drug_enrollment_urls", force: :cascade do |t|
    t.integer  "pbm_specialty_pharmacy_id"
    t.integer  "drug_id"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pbm_specialty_pharmacy_drugs", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "pbm_specialty_pharmacy_id"
    t.integer  "drug_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pbm_specialty_pharmacy_drugs_temp", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "health_plan_id"
    t.integer  "pbm_specialty_pharmacy_id"
    t.integer  "drug_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pbm_specialty_pharmacy_specialization", force: :cascade do |t|
    t.integer  "active",                      default: 1,       null: false
    t.integer  "pharmacyid_fk",                                 null: false
    t.string   "description",   limit: 65536
    t.string   "url",           limit: 500
    t.integer  "creatorid_fk"
    t.datetime "create_stamp",                default: "now()"
    t.integer  "modbyid_fk"
    t.datetime "mod_stamp"
  end

  create_table "pbmfunction", force: :cascade do |t|
    t.string  "name",    limit: 200, null: false
    t.string  "webname", limit: 200
    t.integer "orderid",             null: false
  end

  create_table "pdfpublisher", primary_key: "entityid", force: :cascade do |t|
    t.string   "pdf",             limit: 100
    t.string   "id",              limit: 100
    t.string   "site",            limit: 255
    t.string   "template",        limit: 255
    t.string   "drug",            limit: 255
    t.string   "state",           limit: 255
    t.string   "layout",          limit: 20
    t.string   "formulary_table", limit: 100
    t.integer  "formulary_id"
    t.string   "path",            limit: 255
    t.string   "folder",          limit: 100
    t.string   "file_name",       limit: 255
    t.integer  "userid"
    t.integer  "save",                        default: 0,       null: false
    t.integer  "lock",                        default: 0,       null: false
    t.integer  "zip",                         default: 0,       null: false
    t.datetime "created",                     default: "now()", null: false
    t.integer  "active",                      default: 1,       null: false
  end

  add_index "pdfpublisher", ["drug"], name: "pdfpublisher_drug_idx", using: :btree
  add_index "pdfpublisher", ["file_name"], name: "pdfpublisher_file_name_idx", using: :btree
  add_index "pdfpublisher", ["formulary_id"], name: "pdfpublisher_formulary_id_idx", using: :btree
  add_index "pdfpublisher", ["id"], name: "pdfpublisher_id_idx", using: :btree
  add_index "pdfpublisher", ["pdf"], name: "pdfpublisher_pdf_idx", using: :btree
  add_index "pdfpublisher", ["site"], name: "pdfpublisher_site_idx", using: :btree
  add_index "pdfpublisher", ["state"], name: "pdfpublisher_state_idx", using: :btree
  add_index "pdfpublisher", ["template"], name: "pdfpublisher_template_idx", using: :btree

  create_table "pdp_region_code", id: false, force: :cascade do |t|
    t.integer "code"
    t.string  "state", limit: 2
  end

  create_table "people", force: :cascade do |t|
    t.integer  "type",                    default: 1, null: false
    t.string   "lastname",    limit: 50
    t.string   "firstname",   limit: 50
    t.string   "title",       limit: 100
    t.string   "phonemain",   limit: 20
    t.string   "phonemobile", limit: 20
    t.string   "fax",         limit: 20
    t.string   "email",       limit: 100
    t.string   "notes",       limit: 500
    t.datetime "created",                             null: false
    t.datetime "modified"
    t.string   "modifiedby",  limit: 100
    t.integer  "active",                  default: 1, null: false
  end

  create_table "peopletypes", force: :cascade do |t|
    t.string  "type",        limit: 50,              null: false
    t.string  "description", limit: 100
    t.integer "active",                  default: 1, null: false
  end

  create_table "pfizer_available_order_quantities", force: :cascade do |t|
    t.integer  "quantity_ordered"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "drug_name",        limit: 255
  end

  create_table "pfizer_business_units", force: :cascade do |t|
    t.string  "name",     limit: 255
    t.boolean "isactive",             default: true
  end

  add_index "pfizer_business_units", ["name"], name: "pfizer_business_units_name_key", unique: true, using: :btree

  create_table "pfizer_custom_msa_names", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "msa_id"
    t.string   "name",       limit: 255
  end

  create_table "pfizer_custom_restriction_criteria", force: :cascade do |t|
    t.integer  "criteriafid"
    t.integer  "reportfid"
    t.integer  "pfizer_custom_restriction_criteria_group_id"
    t.boolean  "is_excluded"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_custom_restriction_criteria_group", force: :cascade do |t|
    t.integer  "reportfid"
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_drug_labels", force: :cascade do |t|
    t.integer  "drug_id"
    t.string   "label",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_drug_plan_inclusions", force: :cascade do |t|
    t.integer  "drug_id",                         null: false
    t.integer  "healthplan_id",                   null: false
    t.datetime "created_at",    default: "now()", null: false
  end

  add_index "pfizer_drug_plan_inclusions", ["drug_id", "healthplan_id"], name: "pfizer_drug_plan_inclusions_drug_id_hp_id", using: :btree
  add_index "pfizer_drug_plan_inclusions", ["drug_id"], name: "pfizer_drug_plan_inclusions_drug_id", using: :btree
  add_index "pfizer_drug_plan_inclusions", ["healthplan_id"], name: "pfizer_drug_plan_inclusions_healthplan_id", using: :btree

  create_table "pfizer_drug_plan_labels", force: :cascade do |t|
    t.integer  "drug_id",                          null: false
    t.integer  "health_plan_id",                   null: false
    t.integer  "label_id",                         null: false
    t.datetime "created_at",     default: "now()", null: false
    t.integer  "created_by",                       null: false
    t.datetime "updated_at",     default: "now()", null: false
    t.integer  "updated_by",                       null: false
    t.boolean  "is_active",      default: true,    null: false
  end

  create_table "pfizer_formulary_batches", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "site_user_id"
    t.string   "template",       limit: 255
    t.integer  "drug_class_id"
    t.string   "drug_list",      limit: 255
    t.string   "state_list",     limit: 255
    t.string   "region_type",    limit: 255
    t.string   "plan_type_list", limit: 255
    t.integer  "header_option"
    t.integer  "copay_option"
    t.datetime "processed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_formulary_drugclass_template", id: false, force: :cascade do |t|
    t.integer "drugclass_id_fk",                    null: false
    t.string  "spotlight_drugid_list",  limit: 20
    t.string  "spotlight_drug_name",    limit: 50
    t.string  "drugid_competitor_list", limit: 255
    t.string  "template",               limit: 20
    t.string  "name",                   limit: 50
  end

  create_table "pfizer_formulary_order_addresses", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "user_id"
    t.integer  "formulary_order_id"
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "address_1",          limit: 255
    t.string   "address_2",          limit: 255
    t.string   "city",               limit: 255
    t.integer  "state_id"
    t.string   "zip_code",           limit: 255
    t.string   "telephone_1",        limit: 255
    t.string   "telephone_2",        limit: 255
    t.string   "telephone_3",        limit: 255
    t.string   "telephone_4",        limit: 255
    t.string   "email",              limit: 255
    t.boolean  "store",                          default: true
    t.datetime "updated_at"
    t.string   "territory",          limit: 255
  end

  create_table "pfizer_formulary_orders", force: :cascade do |t|
    t.integer  "user_id",                                  null: false
    t.integer  "formulary_id",                             null: false
    t.integer  "quantity",                                 null: false
    t.string   "pdf_file",     limit: 255,                 null: false
    t.boolean  "order_sent",               default: false, null: false
    t.boolean  "order_ftp",                default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_hospital_import_hospitals", force: :cascade do |t|
    t.integer  "pfizer_hospital_import_id"
    t.string   "hcos_id",                   limit: 255
    t.string   "name",                      limit: 255
    t.integer  "state_id"
    t.string   "import_action",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_hospital_imports", force: :cascade do |t|
    t.integer  "pfizer_user_id"
    t.string   "roster_file_name",    limit: 255
    t.string   "roster_content_type", limit: 255
    t.datetime "roster_updated_at"
    t.datetime "imported_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_hospitals", force: :cascade do |t|
    t.string   "hcos_id",    limit: 255
    t.string   "name",       limit: 255
    t.integer  "state_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_ip_access", primary_key: "ip", force: :cascade do |t|
    t.boolean  "isactive",                 default: true
    t.string   "description",  limit: 100
    t.datetime "create_stamp"
    t.datetime "modify_stamp",             default: "now()"
  end

  create_table "pfizer_mobile_request_logs", force: :cascade do |t|
    t.string   "udid",            limit: 255
    t.string   "os_version",      limit: 255
    t.string   "application_key", limit: 255
    t.string   "session_key",     limit: 255
    t.string   "device_model",    limit: 255
    t.string   "url",             limit: 1000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pfizer_mobile_request_logs", ["udid"], name: "index_pfizer_mobile_request_logs_on_udid", using: :btree

  create_table "pfizer_mobile_user_sessions", force: :cascade do |t|
    t.string   "session_key",      limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_accessed_at"
  end

  add_index "pfizer_mobile_user_sessions", ["session_key"], name: "index_pfizer_mobile_user_sessions_on_session_key", using: :btree
  add_index "pfizer_mobile_user_sessions", ["user_id"], name: "index_pfizer_mobile_user_sessions_on_user_id", using: :btree

  create_table "pfizer_ordering_tool_orders", force: :cascade do |t|
    t.string   "status",                 limit: 255
    t.integer  "publisher_formulary_id"
    t.integer  "created_by_user_id"
    t.integer  "quantity"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "address_line_1",         limit: 255
    t.string   "address_line_2",         limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "zip_code",               limit: 255
    t.string   "telephone",              limit: 255
    t.string   "email",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "searchable_order_id"
    t.string   "territory",              limit: 255
  end

  create_table "pfizer_ordering_tool_template_quantities", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.integer  "site_role_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_ordering_tool_template_quantity_limits", force: :cascade do |t|
    t.integer  "max_quantity"
    t.integer  "site_role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "drug_name",    limit: 255
  end

  create_table "pfizer_pdf_accesses", force: :cascade do |t|
    t.datetime "created_at"
    t.integer  "active",                             default: 1
    t.integer  "site_user_id"
    t.integer  "publisher_formulary_id"
    t.integer  "formulary_table_id"
    t.string   "formulary_table_name",   limit: 255
    t.string   "file_name",              limit: 255
    t.string   "environment",            limit: 255
  end

  create_table "pfizer_plan_administration_filter", primary_key: "healthplanid_fk", force: :cascade do |t|
    t.datetime "create_stamp", default: "now()"
    t.integer  "id",           default: "nextval('pfizer_plan_administration_filter_id_seq'::regclass)", null: false
  end

  create_table "pfizer_plan_category", force: :cascade do |t|
    t.string  "name",        limit: 100,             null: false
    t.string  "description", limit: 100
    t.integer "active",                  default: 1, null: false
  end

  create_table "pfizer_plan_tier_label", force: :cascade do |t|
    t.integer  "healthplan_id_fk",                   null: false
    t.integer  "tier_id_fk",                         null: false
    t.integer  "tier_label_id_fk",                   null: false
    t.datetime "create_timestamp", default: "now()"
    t.datetime "modify_timestamp", default: "now()"
  end

  add_index "pfizer_plan_tier_label", ["healthplan_id_fk"], name: "pfizer_tier_label_tier_healthplan_id", using: :btree
  add_index "pfizer_plan_tier_label", ["tier_id_fk"], name: "pfizer_tier_label_tier_tier_id", using: :btree
  add_index "pfizer_plan_tier_label", ["tier_label_id_fk"], name: "pfizer_tier_label_tier_tier_label_id", using: :btree

  create_table "pfizer_plan_type_category", id: false, force: :cascade do |t|
    t.integer "category_id_fk", null: false
    t.integer "plantype_id_fk", null: false
  end

  create_table "pfizer_provider_logos", force: :cascade do |t|
    t.datetime "created_at",              default: "now()"
    t.integer  "user_id"
    t.integer  "provider_id"
    t.string   "label",       limit: 255
    t.string   "file_uri",    limit: 255
  end

  create_table "pfizer_pseudo_states", force: :cascade do |t|
    t.string   "name",     limit: 255
    t.integer  "statefid",                               null: false
    t.datetime "modified",             default: "now()", null: false
    t.integer  "active",               default: 1,       null: false
  end

  add_index "pfizer_pseudo_states", ["statefid"], name: "pfizer_pseudo_states_statefid_idx", using: :btree

  create_table "pfizer_pseudo_states_counties", force: :cascade do |t|
    t.integer  "pseudostatefid",                   null: false
    t.integer  "countyfid",                        null: false
    t.datetime "modified",       default: "now()", null: false
    t.integer  "active",         default: 1,       null: false
  end

  add_index "pfizer_pseudo_states_counties", ["countyfid"], name: "pfizer_pseudo_states_counties_countyfid_idx", using: :btree
  add_index "pfizer_pseudo_states_counties", ["pseudostatefid"], name: "pfizer_pseudo_states_counties_pseudostatefid_idx", using: :btree

  create_table "pfizer_publisher_activity_report_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_publisher_activity_report_states", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_publisher_activity_report_templates", force: :cascade do |t|
    t.integer  "template_id"
    t.string   "template_type",                limit: 255
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_publisher_activity_reports", force: :cascade do |t|
    t.boolean  "use_preset_date"
    t.string   "preset_date",     limit: 255
    t.date     "end_date"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizer_publisher_formularies", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.string   "current_step",                            limit: 255
    t.string   "name",                                    limit: 255
    t.string   "competitor_drug_ids",                     limit: 255, default: ""
    t.integer  "state_id"
    t.integer  "msa_id"
    t.string   "health_plan_types",                       limit: 255, default: ""
    t.string   "commercial_health_plan_ids",              limit: 255, default: ""
    t.string   "medicare_health_plan_ids",                limit: 255, default: ""
    t.string   "medicaid_health_plan_ids",                limit: 255, default: ""
    t.string   "employer_group_health_plan_ids",          limit: 255, default: ""
    t.string   "pbm_health_plan_ids",                     limit: 255, default: ""
    t.string   "doctor_name",                             limit: 255
    t.string   "rep_name",                                limit: 255
    t.integer  "version"
    t.boolean  "display_copay",                                       default: false
    t.boolean  "display_covered_lives",                               default: false
    t.boolean  "is_active",                                           default: true
    t.boolean  "is_published",                                        default: false
    t.integer  "created_by_id"
    t.integer  "legacy_pfizerformulary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "highlighted_health_plan_ids",             limit: 255, default: ""
    t.string   "bolded_health_plan_ids",                  limit: 255, default: ""
    t.integer  "header_type",                                         default: 0
    t.boolean  "include_second_page",                                 default: false
    t.integer  "county_id"
    t.string   "highlighted_tier_status_health_plan_ids", limit: 255, default: ""
    t.string   "bolded_tier_status_health_plan_ids",      limit: 255, default: ""
    t.integer  "plan_type_selected",                                  default: 0,     null: false
    t.integer  "custom_sub_header_option"
    t.string   "hospital_ids",                            limit: 255, default: ""
  end

  create_table "pfizer_publisher_templates", force: :cascade do |t|
    t.string   "name",                                  limit: 255
    t.string   "klass_name",                            limit: 255
    t.string   "spotlight_drug_ids",                    limit: 255, default: ""
    t.string   "competitor_drug_ids",                   limit: 255, default: ""
    t.integer  "health_plan_count_min"
    t.integer  "health_plan_count_max"
    t.integer  "competitor_drug_count_min"
    t.integer  "competitor_drug_count_max"
    t.string   "allowed_role_ids",                      limit: 255, default: ""
    t.boolean  "is_active",                                         default: true
    t.integer  "drug_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allow_copay_when_max_competitor_drugs"
    t.integer  "ff_publisher_template_id"
    t.string   "template_display_group",                limit: 255
    t.boolean  "publisher_engine_only"
    t.string   "activation_change_comment",             limit: 255
    t.boolean  "display_preferred_brand_tier",                      default: false
    t.integer  "min_hospital_count"
    t.integer  "max_hospital_count"
  end

  create_table "pfizer_role_atlas_job_code", id: false, force: :cascade do |t|
    t.integer "pfizer_role_id"
    t.string  "atlas_job_code",  limit: 6
    t.string  "atlas_job_title", limit: 10
    t.string  "atlas_job_desc",  limit: 50
  end

  add_index "pfizer_role_atlas_job_code", ["atlas_job_code"], name: "pfizer_role_atlas_job_code_id", using: :btree

  create_table "pfizer_role_code_map", id: false, force: :cascade do |t|
    t.integer "pfizer_role_id"
    t.string  "pfizer_role_code", limit: 15
  end

  create_table "pfizer_static_file", force: :cascade do |t|
    t.integer  "drug_id",                                      null: false
    t.integer  "state_id"
    t.string   "provider_name",  limit: 255,                   null: false
    t.string   "title",          limit: 255,                   null: false
    t.string   "file_name",      limit: 255,                   null: false
    t.string   "file_type",      limit: 255,                   null: false
    t.integer  "active",                     default: 1,       null: false
    t.datetime "created_at",                 default: "now()", null: false
    t.integer  "create_user_id"
    t.datetime "updated_at"
    t.integer  "update_user_id"
  end

  add_index "pfizer_static_file", ["create_user_id"], name: "pfizer_files_create_user_id", using: :btree
  add_index "pfizer_static_file", ["drug_id"], name: "pfizer_files_drug_id", using: :btree
  add_index "pfizer_static_file", ["state_id"], name: "pfizer_files_state_id", using: :btree
  add_index "pfizer_static_file", ["update_user_id"], name: "pfizer_files_update_user_id", using: :btree

  create_table "pfizer_teams", force: :cascade do |t|
    t.string  "name",     limit: 255
    t.boolean "isactive",             default: true
  end

  add_index "pfizer_teams", ["name"], name: "pfizer_teams_name_key", unique: true, using: :btree

  create_table "pfizer_template_labels", force: :cascade do |t|
    t.integer  "template_id",                                null: false
    t.string   "label",         limit: 50,                   null: false
    t.boolean  "unrestricted",             default: false,   null: false
    t.integer  "display_order", limit: 2,  default: 0,       null: false
    t.datetime "created_at",               default: "now()", null: false
    t.integer  "created_by",                                 null: false
    t.datetime "updated_at",               default: "now()", null: false
    t.integer  "updated_by",                                 null: false
    t.boolean  "is_active",                default: true,    null: false
  end

  create_table "pfizer_tier_label", force: :cascade do |t|
    t.integer  "tier_id_fk",                                         null: false
    t.string   "label",                limit: 255
    t.datetime "create_timestamp",                 default: "now()"
    t.datetime "modify_timestamp",                 default: "now()"
    t.integer  "active",                           default: 1,       null: false
    t.boolean  "display_qual",                     default: true
    t.string   "qualifier_limit_list", limit: 255
    t.string   "medicaid_preference",  limit: 50
  end

  add_index "pfizer_tier_label", ["tier_id_fk"], name: "pfizer_tier_label_tier_id", using: :btree

  create_table "pfizerdrugplanform", primary_key: "entityid", force: :cascade do |t|
    t.integer "formularyfid",               null: false
    t.integer "planid",                     null: false
    t.integer "drugid",                     null: false
    t.integer "coveragestatus",             null: false
    t.boolean "priorauth",                  null: false
    t.boolean "quantlimit",                 null: false
    t.boolean "stepther",                   null: false
    t.boolean "restrother",                 null: false
    t.integer "resaoncodefid",  default: 0, null: false
    t.integer "resetflag",      default: 0, null: false
    t.integer "paforall",       default: 0, null: false
  end

  add_index "pfizerdrugplanform", ["drugid"], name: "pfizerdrugplanform_drugid_idx", using: :btree
  add_index "pfizerdrugplanform", ["formularyfid"], name: "pfizerdrugplanform_formularyid_idx", using: :btree
  add_index "pfizerdrugplanform", ["planid"], name: "pfizerdrugplanform_planid_idx", using: :btree

  create_table "pfizerformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                          null: false
    t.integer  "statefid"
    t.integer  "msafid"
    t.integer  "drugclassfid",                                     null: false
    t.string   "planlist",                                         null: false
    t.string   "druglist",                                         null: false
    t.string   "tableversion",             limit: 100,             null: false
    t.integer  "versionnumber",                        default: 0, null: false
    t.integer  "ispublished",                          default: 0, null: false
    t.integer  "isexported",                           default: 0, null: false
    t.integer  "isactive",                             default: 1, null: false
    t.datetime "createtimestamp",                                  null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "modifytimestamp",                                  null: false
    t.integer  "mostrecent",                           default: 0, null: false
    t.string   "planorderedlist",          limit: 500
    t.string   "planboldedlist",           limit: 500
    t.string   "description",              limit: 100
    t.string   "doctorname",               limit: 100
    t.integer  "tabletype",                            default: 1, null: false
    t.string   "template",                 limit: 50
    t.string   "repname",                  limit: 100
    t.string   "plan_type_category_order", limit: 50
    t.integer  "header_option"
    t.string   "mark_new_list",            limit: 500
    t.string   "geo_area_name",            limit: 255
    t.string   "new_lipitor",              limit: 500
    t.string   "new_caduet",               limit: 500
    t.integer  "copay_option",                         default: 0, null: false
    t.string   "competitor_drug_order",    limit: 255
    t.integer  "provider_logo_id"
    t.string   "free_text_menu",           limit: 1
    t.string   "free_text_other",          limit: 255
    t.string   "provider_name",            limit: 255
    t.integer  "display_tier_status",                  default: 1, null: false
  end

  add_index "pfizerformulary", ["drugclassfid"], name: "pfizerformulary_drugclassid_idx", using: :btree
  add_index "pfizerformulary", ["msafid"], name: "pfizerformulary_msaid_idx", using: :btree
  add_index "pfizerformulary", ["statefid"], name: "pfizerformulary_stateid_idx", using: :btree
  add_index "pfizerformulary", ["userfid"], name: "pfizerformulary_userid_idx", using: :btree

  create_table "pfizerformulary_approval", force: :cascade do |t|
    t.integer  "pfizerformulary_id", limit: 8,  null: false
    t.string   "approval_status",    limit: 50, null: false
    t.datetime "created_at",                    null: false
    t.integer  "created_by",         limit: 8,  null: false
    t.datetime "updated_at",                    null: false
    t.integer  "updated_by",         limit: 8,  null: false
    t.datetime "approved_at"
    t.integer  "approved_by",        limit: 8
  end

  create_table "pfizermsa", force: :cascade do |t|
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 100
    t.datetime "modified",                default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "pfizermsastate", force: :cascade do |t|
    t.integer  "msafid",                     null: false
    t.integer  "statefid",                   null: false
    t.datetime "modified", default: "now()", null: false
    t.integer  "active",   default: 1,       null: false
  end

  add_index "pfizermsastate", ["msafid"], name: "pfizermsa_state_msaid_idx", using: :btree

  create_table "pfizerpro_address", force: :cascade do |t|
    t.integer  "addresstypefid",             default: 1,       null: false
    t.string   "address",        limit: 200
    t.string   "city",           limit: 200
    t.integer  "statefid"
    t.integer  "countryfid"
    t.string   "postalcode",     limit: 50
    t.string   "geocode",        limit: 50
    t.datetime "created",                    default: "now()", null: false
    t.integer  "active",                     default: 1,       null: false
  end

  create_table "pfizerpro_address_user", force: :cascade do |t|
    t.integer "addressfid", null: false
    t.integer "userfid",    null: false
  end

  create_table "pfizerpro_formulary_log", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "drug_id",        null: false
    t.integer  "health_plan_id", null: false
    t.integer  "state_id",       null: false
    t.datetime "created_at",     null: false
  end

  create_table "pfizerpro_health_plan_phone_numbers", force: :cascade do |t|
    t.integer "health_plan_id",            null: false
    t.string  "phone_number",   limit: 50, null: false
  end

  create_table "pfizerpro_health_plan_phone_numbers_temp", id: false, force: :cascade do |t|
    t.integer "health_plan_id"
    t.string  "phone_number",   limit: 50
  end

  create_table "pfizerpro_jobtype", force: :cascade do |t|
    t.string   "name",            limit: 100,                   null: false
    t.integer  "usertypefid",                                   null: false
    t.integer  "requireapproval",             default: 0,       null: false
    t.datetime "created",                     default: "now()", null: false
    t.integer  "orderindex",      limit: 2
    t.integer  "active",                      default: 1,       null: false
  end

  create_table "pfizerpro_jobtypepermission", force: :cascade do |t|
    t.integer  "jobtypefid",                        null: false
    t.integer  "permissionfid",                     null: false
    t.integer  "permissionvalue",                   null: false
    t.datetime "created",         default: "now()", null: false
    t.integer  "createdby",                         null: false
    t.datetime "modified",                          null: false
    t.integer  "modifiedby",                        null: false
    t.integer  "active",          default: 1,       null: false
  end

  create_table "pfizerpro_phone", force: :cascade do |t|
    t.integer  "phonetypefid",            default: 1,       null: false
    t.string   "number",       limit: 50,                   null: false
    t.string   "ext",          limit: 10
    t.datetime "created",                 default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "pfizerpro_phone_user", force: :cascade do |t|
    t.integer "phonefid", null: false
    t.integer "userfid",  null: false
  end

  create_table "pfizerpro_priorauth_log", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "health_plan_id", null: false
    t.datetime "created_at",     null: false
  end

  create_table "pfizerpro_restriction_documents", force: :cascade do |t|
    t.integer  "health_plan_id",             null: false
    t.integer  "drug_id"
    t.string   "document_name",  limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pfizerpro_restriction_documents_backup_20130620", id: false, force: :cascade do |t|
    t.integer "health_plan_id",             null: false
    t.integer "drug_id"
    t.string  "document_name",  limit: 255, null: false
  end

  create_table "pfizerpro_restriction_documents_temp", id: false, force: :cascade do |t|
    t.integer "health_plan_id"
    t.integer "drug_id"
    t.string  "document_name",  limit: 255
  end

  create_table "pfizerpro_restriction_landing_pages", force: :cascade do |t|
    t.integer "health_plan_id"
    t.string  "url",            limit: 1000
  end

  create_table "pfizerpro_restriction_landing_pages_20121008", id: false, force: :cascade do |t|
    t.integer "health_plan_id"
    t.string  "url",            limit: 1000
  end

  create_table "pfizerpro_restriction_landing_pages_temp", id: false, force: :cascade do |t|
    t.integer "health_plan_id"
    t.string  "url",            limit: 1000
    t.integer "id"
  end

  create_table "pfizerpro_user", force: :cascade do |t|
    t.string   "email",             limit: 255,                   null: false
    t.string   "password",          limit: 255,                   null: false
    t.datetime "passwordtimestamp",             default: "now()", null: false
    t.string   "salutation",        limit: 10
    t.string   "fullname",          limit: 255,                   null: false
    t.string   "firstname",         limit: 255
    t.string   "lastname",          limit: 255
    t.integer  "jobtypefid",                                      null: false
    t.string   "jobtypeother",      limit: 100
    t.string   "practicename",      limit: 100
    t.integer  "optin",                         default: 0,       null: false
    t.integer  "status",                        default: 0,       null: false
    t.integer  "access",                        default: 0,       null: false
    t.datetime "created",                       default: "now()", null: false
    t.integer  "createdby",                                       null: false
    t.datetime "modified",                                        null: false
    t.integer  "modifiedby",                                      null: false
    t.integer  "active",                        default: 1,       null: false
    t.integer  "statefid"
    t.string   "specialty",         limit: 100
  end

  create_table "pfizerpro_user_download", force: :cascade do |t|
    t.integer  "pfizerpro_userfid",             null: false
    t.string   "type",              limit: 10
    t.string   "version",           limit: 10
    t.datetime "lastupdate"
    t.string   "user_ip",           limit: 20
    t.string   "http_user_agent",   limit: 200
    t.string   "http_host",         limit: 100
  end

  create_table "pfizerpro_useralert", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
  end

  create_table "pfizerpro_userdrug", force: :cascade do |t|
    t.integer "userfid", null: false
    t.integer "drugfid", null: false
  end

  add_index "pfizerpro_userdrug", ["drugfid"], name: "pfizerpro_userdrug_drugfid_idx", using: :btree
  add_index "pfizerpro_userdrug", ["userfid"], name: "pfizerpro_userdrug_userfid_idx", using: :btree

  create_table "pfizerpro_userhealthplan", force: :cascade do |t|
    t.integer "userfid",       null: false
    t.integer "healthplanfid", null: false
    t.integer "statefid",      null: false
  end

  add_index "pfizerpro_userhealthplan", ["healthplanfid"], name: "pfizerpro_userhealthplan_healthplanfid_idx", using: :btree
  add_index "pfizerpro_userhealthplan", ["userfid"], name: "pfizerpro_userhealthplan_userfid_idx", using: :btree

  create_table "pfizerpro_userservice", force: :cascade do |t|
    t.integer "userfid",      null: false
    t.integer "drugclassfid"
  end

  create_table "pfizerpro_usersession", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.string   "sessionid",             limit: 200, null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                    null: false
    t.datetime "lastaccessedtimestamp",             null: false
  end

  create_table "pfizerrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",                limit: 50,                  null: false
    t.string   "description",         limit: 500
    t.integer  "adminonly",                       default: 0,     null: false
    t.integer  "requiresapproval",                default: 0,     null: false
    t.integer  "createtable",                     default: 0,     null: false
    t.datetime "createtimestamp",                                 null: false
    t.datetime "modifytimestamp",                                 null: false
    t.string   "pfizer_role_code",    limit: 20
    t.boolean  "is_super_user",                   default: false
    t.integer  "active"
    t.integer  "view_formulary_data",             default: 0,     null: false
  end

  create_table "pfizeruser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",                    limit: 200,                   null: false
    t.string   "password",                 limit: 200,                   null: false
    t.string   "firstname",                limit: 200,                   null: false
    t.string   "lastname",                 limit: 200,                   null: false
    t.integer  "rolefid",                                                null: false
    t.integer  "isactive",                             default: 0,       null: false
    t.integer  "isalerts",                             default: 0,       null: false
    t.integer  "isapproved",                           default: 0,       null: false
    t.string   "activationkey",            limit: 50,                    null: false
    t.datetime "createtimestamp",                                        null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                      default: "now()", null: false
    t.string   "pfizer_business_unit",     limit: 255
    t.string   "pfizer_employee_id",       limit: 20
    t.string   "pfizer_employee_id_md5",   limit: 32
    t.string   "pfizer_ntid",              limit: 200
    t.string   "pfizer_ntid_md5",          limit: 32
    t.string   "pfizer_role_code",         limit: 20
    t.integer  "pfizer_territory_id"
    t.string   "pfizer_territory_desc",    limit: 255
    t.boolean  "pfizer_import",                        default: false
    t.string   "pfizer_manager_id",        limit: 20
    t.integer  "isanalytics",              limit: 2,   default: 0,       null: false
    t.integer  "pfizer_bu_id"
    t.integer  "pfizer_team_id"
    t.integer  "pfizer_sales_position_id"
  end

  add_index "pfizeruser", ["email"], name: "pfizeruser_email_key_new", unique: true, using: :btree
  add_index "pfizeruser", ["pfizer_employee_id"], name: "pfizeruser_pfizer_employee_id_key", unique: true, using: :btree
  add_index "pfizeruser", ["pfizer_ntid"], name: "pfizeruser_pfizer_ntid_key_new", unique: true, using: :btree

  create_table "pfizeruseralert", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.datetime "archived_at"
  end

  create_table "pfizeruserservice", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid",      null: false
    t.integer "drugclassfid"
  end

  create_table "pfizerusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "pharmacistprogress", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "healthplanfid",                     null: false
    t.integer  "drugclassfid",                      null: false
    t.datetime "createtimestamp", default: "now()", null: false
  end

  create_table "pjg_foobarbaztest", id: false, force: :cascade do |t|
    t.string "name", limit: 10
  end

  create_table "plan_mappings_no_matches", force: :cascade do |t|
    t.string  "type",    limit: 255, null: false
    t.integer "plan_id",             null: false
    t.string  "reason",  limit: 255
  end

  add_index "plan_mappings_no_matches", ["type", "plan_id"], name: "index_plan_mappings_no_matches_on_type_and_plan_id", using: :btree

  create_table "planformtracking", force: :cascade do |t|
    t.integer  "healthplanfid", null: false
    t.integer  "formularyfid",  null: false
    t.integer  "createdby"
    t.datetime "created"
  end

  create_table "provider", force: :cascade do |t|
    t.boolean "isactive",                                         null: false
    t.string  "name",                limit: 255,                  null: false
    t.string  "webname",             limit: 255,                  null: false
    t.integer "suppressrollup",                   default: 0,     null: false
    t.string  "altwebname",          limit: 255,                  null: false
    t.integer "parentsfid"
    t.integer "corporatestructure"
    t.string  "ptdates",             limit: 1000
    t.string  "ptmembers",           limit: 1000
    t.string  "ptcomments",          limit: 1000
    t.boolean "top_provider",                     default: false
    t.boolean "is_medical_benefits",              default: false
  end

  add_index "provider", ["name"], name: "provider_name_key", unique: true, using: :btree
  add_index "provider", ["webname"], name: "provider_webname_key", unique: true, using: :btree

  create_table "provider_contact_notes", force: :cascade do |t|
    t.integer  "provider_contact_id",                null: false
    t.text     "note"
    t.boolean  "active",              default: true, null: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_contact_notes", ["provider_contact_id"], name: "index_provider_contact_notes_on_provider_contact_id", using: :btree

  create_table "provider_contacts", force: :cascade do |t|
    t.integer  "site_id",                  default: 1,    null: false
    t.integer  "provider_id",                             null: false
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "title",        limit: 255
    t.string   "address_1",    limit: 255
    t.string   "address_2",    limit: 255
    t.string   "city",         limit: 255
    t.integer  "state_id"
    t.string   "postal_code",  limit: 255
    t.string   "phone_1",      limit: 255
    t.string   "phone_2",      limit: 255
    t.string   "phone_mobile", limit: 255
    t.string   "phone_fax",    limit: 255
    t.string   "email",        limit: 255
    t.boolean  "active",                   default: true, null: false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provider_contacts", ["email"], name: "index_provider_contacts_on_email", using: :btree
  add_index "provider_contacts", ["first_name"], name: "index_provider_contacts_on_first_name", using: :btree
  add_index "provider_contacts", ["last_name"], name: "index_provider_contacts_on_last_name", using: :btree
  add_index "provider_contacts", ["provider_id"], name: "index_provider_contacts_on_provider_id", using: :btree
  add_index "provider_contacts", ["site_id"], name: "index_provider_contacts_on_site_id", using: :btree
  add_index "provider_contacts", ["state_id"], name: "index_provider_contacts_on_state_id", using: :btree

  create_table "provider_medicare_exception", force: :cascade do |t|
    t.integer "providerfid",                    null: false
    t.integer "statefid",                       null: false
    t.integer "medicare_exception", default: 0, null: false
  end

  create_table "provider_prior_authorization_departments", force: :cascade do |t|
    t.integer  "provider_id"
    t.string   "address_line_1", limit: 255
    t.string   "address_line_2", limit: 255
    t.string   "city",           limit: 255
    t.integer  "state_id"
    t.string   "postal_code",    limit: 255
    t.string   "phone",          limit: 255
    t.string   "fax",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provideraddress", force: :cascade do |t|
    t.integer "providerfid", null: false
    t.integer "addressfid",  null: false
  end

  add_index "provideraddress", ["providerfid", "addressfid"], name: "provideraddress_providerfid_key", unique: true, using: :btree

  create_table "providercomment", force: :cascade do |t|
    t.integer "providerfid", null: false
    t.integer "commentfid",  null: false
  end

  add_index "providercomment", ["providerfid", "commentfid"], name: "providercomment_providerfid_key", unique: true, using: :btree

  create_table "providercontact", force: :cascade do |t|
    t.integer "providerfid", null: false
    t.integer "contactfid",  null: false
  end

  add_index "providercontact", ["providerfid", "contactfid"], name: "providercontact_providerfid_key", unique: true, using: :btree

  create_table "providergroup", force: :cascade do |t|
    t.integer  "providerfid",       null: false
    t.integer  "healthplantypefid", null: false
    t.integer  "groupnumber",       null: false
    t.datetime "modifytimestamp",   null: false
    t.integer  "modifyuser",        null: false
  end

  add_index "providergroup", ["providerfid", "healthplantypefid"], name: "provider_plantype_uk", unique: true, using: :btree

  create_table "providermanagement", force: :cascade do |t|
    t.string  "name",        limit: 200, null: false
    t.integer "providerfid",             null: false
    t.string  "title",       limit: 200, null: false
  end

  create_table "providermanagement_backup", id: false, force: :cascade do |t|
    t.integer "id"
    t.string  "name",        limit: 200
    t.integer "providerfid"
    t.string  "title",       limit: 200
  end

  create_table "providernotes", force: :cascade do |t|
    t.integer "providerfid",             null: false
    t.integer "notesfid",                null: false
    t.integer "active",      default: 1, null: false
    t.integer "statefid"
  end

  create_table "providerpeople", force: :cascade do |t|
    t.integer "providerfid",             null: false
    t.integer "peoplefid",               null: false
    t.integer "active",      default: 1, null: false
  end

  create_table "purdue_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2010-01-22 13:40:32'
    t.datetime "updated_at",                              default: '2010-01-22 13:40:32'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
    t.integer  "ff_publisher_template_id"
    t.integer  "header_type",                             default: 0
  end

  add_index "purdue_formularies", ["drug_class_id"], name: "purdue_formularies_drug_class_id_idx", using: :btree
  add_index "purdue_formularies", ["site_user_id"], name: "purdue_formularies_site_user_id_idx", using: :btree
  add_index "purdue_formularies", ["state_id"], name: "purdue_formularies_state_id_idx", using: :btree
  add_index "purdue_formularies", ["template"], name: "purdue_formularies_template_idx", using: :btree

  create_table "purdue_ordering_tool_line_items", force: :cascade do |t|
    t.integer  "ordering_tool_user_id"
    t.integer  "ordering_tool_order_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purdue_ordering_tool_orders", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                 limit: 255
    t.integer  "formulary_table_id"
    t.integer  "created_by_user_id"
    t.integer  "publisher_formulary_id"
  end

  create_table "purdue_ordering_tool_users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_user_id"
    t.string   "address",             limit: 255
    t.string   "territory",           limit: 255
    t.string   "city",                limit: 255
    t.string   "state",               limit: 255
    t.string   "postal_code",         limit: 255
    t.string   "phone",               limit: 255
    t.integer  "district_manager_id"
    t.string   "type",                limit: 255
    t.string   "region",              limit: 255
    t.string   "title",               limit: 255
  end

  create_table "purdue_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "formulary_table_name",   limit: 255
    t.integer  "formulary_table_id"
    t.string   "environment",            limit: 255
    t.string   "file_name",              limit: 255
    t.string   "pdf_unique_id",          limit: 255
    t.integer  "publisher_formulary_id"
  end

  create_table "purdue_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "purdue_plan_drug_options", ["created_by"], name: "purdue_plan_drug_options_created_by_idx", using: :btree
  add_index "purdue_plan_drug_options", ["updated_by"], name: "purdue_plan_drug_options_updated_by_idx", using: :btree

  create_table "purdue_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "purdue_plan_drug_settings", ["created_by"], name: "purdue_plan_drug_settings_created_by_idx", using: :btree
  add_index "purdue_plan_drug_settings", ["drug_id"], name: "purdue_plan_drug_settings_drug_id_idx", using: :btree
  add_index "purdue_plan_drug_settings", ["healthplan_id"], name: "purdue_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "purdue_plan_drug_settings", ["plan_drug_option_id"], name: "purdue_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "purdue_plan_drug_settings", ["state_id"], name: "purdue_plan_drug_settings_state_id_idx", using: :btree
  add_index "purdue_plan_drug_settings", ["updated_by"], name: "purdue_plan_drug_settings_updated_by_idx", using: :btree

  create_table "purdue_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purdue_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purdue_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "purdue_plan_type_groups", force: :cascade do |t|
    t.string "name", limit: 10
  end

  create_table "purdue_publisher_activity_report_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purdue_publisher_activity_report_states", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purdue_publisher_activity_report_templates", force: :cascade do |t|
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "template_id"
    t.string   "template_type",                limit: 255
  end

  create_table "purdue_publisher_activity_reports", force: :cascade do |t|
    t.boolean  "use_preset_date"
    t.string   "preset_date",     limit: 255
    t.date     "end_date"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purdue_publisher_formularies", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.string   "current_step",                    limit: 255
    t.string   "name",                            limit: 255
    t.string   "competitor_drug_ids",             limit: 255, default: ""
    t.integer  "state_id"
    t.string   "geographic_customization",        limit: 255
    t.string   "health_plan_types",               limit: 255, default: ""
    t.string   "commercial_health_plan_ids",      limit: 255, default: ""
    t.string   "medicare_health_plan_ids",        limit: 255, default: ""
    t.string   "medicaid_health_plan_ids",        limit: 255, default: ""
    t.string   "bolded_health_plan_ids",          limit: 255, default: ""
    t.string   "highlighted_health_plan_ids",     limit: 255, default: ""
    t.integer  "header_type"
    t.integer  "version"
    t.integer  "created_by_id"
    t.boolean  "is_active",                                   default: true
    t.boolean  "is_published",                                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_selected_health_plan_types", limit: 255
    t.string   "channel_type",                    limit: 255
    t.boolean  "display_copay",                               default: false
  end

  create_table "purdue_publisher_templates", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.string   "klass_name",                 limit: 255
    t.string   "spotlight_drug_ids",         limit: 255, default: ""
    t.string   "competitor_drug_ids",        limit: 255, default: ""
    t.integer  "health_plan_count_min"
    t.integer  "health_plan_count_max"
    t.integer  "competitor_drug_count_min"
    t.integer  "competitor_drug_count_max"
    t.string   "allowed_role_ids",           limit: 255, default: ""
    t.boolean  "is_active",                              default: true
    t.integer  "drug_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_html_pdf",                            default: true
    t.integer  "template_amendment_type_id"
  end

  create_table "purdue_roles", force: :cascade do |t|
    t.string   "role",                       limit: 200
    t.string   "description",                limit: 200
    t.integer  "adminonly",                              default: 0
    t.integer  "requires_approval",                      default: 0
    t.integer  "formulary_tables",                       default: 0
    t.integer  "analytics",                              default: 0
    t.integer  "accounts",                               default: 0,                     null: false
    t.integer  "active",                                 default: 1
    t.datetime "created_at",                             default: '2010-01-22 13:40:31'
    t.datetime "updated_at",                             default: '2010-01-22 13:40:31'
    t.boolean  "formulary_table_orders",                 default: false
    t.boolean  "formulary_table_creation",               default: false
    t.integer  "restrictions",                           default: 0
    t.boolean  "is_super_user",                          default: false
    t.boolean  "publisher_reporting",                    default: false,                 null: false
    t.boolean  "can_see_others_formularies"
    t.boolean  "is_manager"
    t.boolean  "requestable"
    t.integer  "alerts",                                 default: 0,                     null: false
  end

  create_table "purdue_template_amendment_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purdue_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "purdue_user_alerts", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.integer  "legacyfid"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "archived_at"
  end

  create_table "purdue_user_services", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid"
    t.integer "drugclassfid"
  end

  create_table "purdue_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-01-22 13:40:31'
    t.datetime "last_accessed_timestamp",             default: '2010-01-22 13:40:31'
  end

  create_table "purdue_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "purplepass", force: :cascade do |t|
    t.string   "token",           limit: 100,                null: false
    t.string   "email",           limit: 200
    t.boolean  "isactive",                    default: true, null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "modifytimestamp",                            null: false
  end

  create_table "purplepassalert", force: :cascade do |t|
    t.integer  "healthplanfid"
    t.integer  "drugfid"
    t.integer  "formularyentryfid"
    t.integer  "orderindex",                        null: false
    t.integer  "tierfid",           default: 8
    t.boolean  "priorauth",         default: false, null: false
    t.boolean  "quantlimit",        default: false, null: false
    t.boolean  "stepther",          default: false, null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "resetflag",         default: false
  end

  create_table "purplepasshealthplan", force: :cascade do |t|
    t.integer  "purplepassfid",   null: false
    t.integer  "healthplanfid",   null: false
    t.datetime "createtimestamp", null: false
  end

  create_table "purplepassservice", force: :cascade do |t|
    t.integer  "purplepassfid",   null: false
    t.integer  "drugclassfid",    null: false
    t.integer  "healthplanfid",   null: false
    t.datetime "createtimestamp", null: false
  end

  create_table "purplepasssession", force: :cascade do |t|
    t.integer  "purplepassfid",                     null: false
    t.string   "sessionid",             limit: 200, null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                    null: false
    t.datetime "lastaccessedtimestamp",             null: false
  end

  create_table "purplepassuseralert", force: :cascade do |t|
    t.integer  "purplepassfid",     null: false
    t.integer  "healthplanfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "formularyentryfid"
    t.integer  "tierfidold"
    t.integer  "tierfidnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",    null: false
    t.datetime "createtimestamp",   null: false
    t.boolean  "isemailsent"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
  end

  create_table "ql_drug_strength_limits", force: :cascade do |t|
    t.integer "drug_strength_id"
    t.integer "feq_criteria_entry_id"
    t.boolean "is_restricted",                     default: false
    t.text    "comment"
    t.float   "dosage_quantity_1"
    t.string  "dosage_unit_1",         limit: 255
    t.float   "period_quantity_1"
    t.string  "period_unit_1",         limit: 255
    t.float   "dosage_quantity_2"
    t.string  "dosage_unit_2",         limit: 255
    t.float   "period_quantity_2"
    t.string  "period_unit_2",         limit: 255
    t.float   "daily_limit"
  end

  add_index "ql_drug_strength_limits", ["drug_strength_id"], name: "drug_strength_id_idx", using: :btree
  add_index "ql_drug_strength_limits", ["feq_criteria_entry_id"], name: "feq_criteria_entry_id_idx", using: :btree

  create_table "qualifier", force: :cascade do |t|
    t.boolean "isactive",                            null: false
    t.string  "name",                    limit: 255, null: false
    t.string  "codename",                limit: 20,  null: false
    t.text    "explanationtext"
    t.integer "orderindex",                          null: false
    t.integer "restrictionsindex"
    t.integer "restrictionsreportindex"
  end

  add_index "qualifier", ["codename"], name: "qualifier_codename_key", unique: true, using: :btree
  add_index "qualifier", ["name"], name: "qualifier_name_key", unique: true, using: :btree
  add_index "qualifier", ["orderindex"], name: "qualifier_orderindex_key", unique: true, using: :btree

  create_table "qualifier_form_landing_page", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "provider_id",                                   null: false
    t.text     "site_url"
    t.boolean  "is_active"
    t.integer  "created_by",                                    null: false
    t.datetime "created_at",                      precision: 6, null: false
    t.integer  "updated_by",                                    null: false
    t.datetime "updated_at",                      precision: 6, null: false
    t.text     "website_url"
    t.text     "landing_page",                                  null: false
    t.integer  "health_plan_type_id",                           null: false
    t.string   "updated_by_name",     limit: 200,               null: false
    t.datetime "super_copy_date"
    t.integer  "super_copy_by_id"
    t.string   "super_copy_by_name",  limit: 200
  end

  create_table "qualifier_form_landing_pages", force: :cascade do |t|
    t.integer  "health_plan_id",                               null: false
    t.integer  "provider_id"
    t.string   "site_url",       limit: 500,                   null: false
    t.boolean  "is_active",                  default: true
    t.integer  "created_by",                                   null: false
    t.datetime "created_at",                 default: "now()", null: false
    t.integer  "updated_by",                                   null: false
    t.datetime "updated_at",                 default: "now()", null: false
    t.string   "website_url",    limit: 255
  end

  create_table "qualifier_form_landing_pages_drug", force: :cascade do |t|
    t.integer  "provider_id",                                                                  null: false
    t.integer  "health_plan_type_id",                                                          null: false
    t.integer  "health_plan_id"
    t.integer  "drug_class_id",                                                                null: false
    t.integer  "drug_id",                                                                      null: false
    t.text     "pa_form_link"
    t.boolean  "pa_form_link_dc_chk",                                        default: false
    t.text     "specialty_enrollment_link"
    t.boolean  "specialty_enrollment_link_dc_chk",                           default: false
    t.text     "pa_policy_link"
    t.boolean  "pa_policy_link_dc_chk",                                      default: false
    t.text     "med_policy_link"
    t.boolean  "med_policy_link_dc_chk",                                     default: false
    t.datetime "updated_at",                                   precision: 6, default: "now()", null: false
    t.integer  "updated_by_id",                                                                null: false
    t.string   "updated_by_name",                  limit: 200,                                 null: false
    t.datetime "created_at",                                   precision: 6, default: "now()", null: false
    t.string   "created_by",                                                                   null: false
    t.boolean  "is_active",                                                  default: true
    t.datetime "super_copy_date"
    t.integer  "super_copy_by_id"
    t.string   "super_copy_by_name",               limit: 200
  end

  create_table "qualifier_form_landing_pages_drug_class", force: :cascade do |t|
    t.integer  "provider_id",                                                           null: false
    t.integer  "health_plan_type_id",                                                   null: false
    t.integer  "health_plan_id"
    t.integer  "drug_class_id"
    t.text     "pa_form_link"
    t.text     "specialty_enrollment_link"
    t.text     "pa_policy_link"
    t.text     "med_policy_link"
    t.datetime "updated_at",                            precision: 6, default: "now()", null: false
    t.integer  "updated_by_id",                                                         null: false
    t.string   "updated_by_name",           limit: 200,                                 null: false
    t.datetime "created_at",                            precision: 6, default: "now()", null: false
    t.string   "created_by",                                                            null: false
    t.boolean  "is_active",                                           default: true
    t.datetime "super_copy_date"
    t.integer  "super_copy_by_id"
    t.string   "super_copy_by_name",        limit: 200
  end

  create_table "reasoncode", force: :cascade do |t|
    t.string   "code",            limit: 10,                    null: false
    t.string   "text",            limit: 100,                   null: false
    t.string   "webtext",         limit: 500,                   null: false
    t.integer  "isactive",                    default: 1,       null: false
    t.datetime "createtimestamp",             default: "now()", null: false
    t.datetime "modifytimestamp",             default: "now()", null: false
    t.integer  "modifiedby",                                    null: false
    t.string   "webtext_sp",      limit: 500
    t.integer  "qualifier_id"
  end

  create_table "report_criteria_positions", force: :cascade do |t|
    t.integer  "restriction_report_id"
    t.integer  "criteria_id"
    t.integer  "position"
    t.datetime "created_at",            default: "now()"
    t.datetime "updated_at",            default: "now()"
  end

  create_table "report_formulary_assignment_summaries", force: :cascade do |t|
    t.integer "the_year",                       null: false
    t.integer "the_month",                      null: false
    t.integer "the_day",                        null: false
    t.integer "brief_update_count", default: 0, null: false
    t.integer "full_update_count",  default: 0, null: false
    t.integer "validation_count",   default: 0, null: false
  end

  create_table "restriction_mv1", id: false, force: :cascade do |t|
    t.integer "drugfid"
    t.string  "restrictionflag",     limit: 5
    t.integer "reportfid"
    t.integer "criteriafid"
    t.integer "healthplantypefid"
    t.boolean "isactive"
    t.integer "id"
    t.integer "providerfid"
    t.integer "reasoncodefid"
    t.string  "name",                limit: 255
    t.string  "webname",             limit: 255
    t.string  "formularyurl",        limit: 500
    t.integer "fe_id"
    t.integer "tierfid"
    t.integer "qualifierfid"
    t.text    "value_text"
    t.decimal "value_numeric_start"
    t.integer "value_numeric_end"
    t.string  "value_units",         limit: 255
  end

  add_index "restriction_mv1", ["criteriafid"], name: "restriction_mv3_idx", using: :btree
  add_index "restriction_mv1", ["drugfid"], name: "restriction_mv1_idx", using: :btree
  add_index "restriction_mv1", ["healthplantypefid"], name: "restriction_mv4_idx", using: :btree
  add_index "restriction_mv1", ["id"], name: "restriction_mv5_idx", using: :btree
  add_index "restriction_mv1", ["providerfid"], name: "restriction_mv6_idx", using: :btree
  add_index "restriction_mv1", ["reportfid"], name: "restriction_mv2_idx", using: :btree
  add_index "restriction_mv1", ["value_numeric_end"], name: "restriction_mv8_idx", using: :btree
  add_index "restriction_mv1", ["value_numeric_start"], name: "restriction_mv7_idx", using: :btree
  add_index "restriction_mv1", ["value_units"], name: "restriction_mv9_idx", using: :btree

  create_table "restriction_mv2", id: false, force: :cascade do |t|
    t.integer "drugfid"
    t.integer "id"
    t.boolean "isactive"
    t.integer "healthplantypefid"
  end

  add_index "restriction_mv2", ["drugfid"], name: "restriction_mv21_idx", using: :btree
  add_index "restriction_mv2", ["healthplantypefid"], name: "restriction_mv23_idx", using: :btree
  add_index "restriction_mv2", ["id"], name: "restriction_mv22_idx", using: :btree

  create_table "restriction_mv3", id: false, force: :cascade do |t|
    t.integer "healthplanfid"
    t.integer "statefid"
    t.decimal "lives"
  end

  add_index "restriction_mv3", ["healthplanfid"], name: "restriction_mv31_idx", using: :btree
  add_index "restriction_mv3", ["statefid"], name: "restriction_mv32_idx", using: :btree

  create_table "restriction_mv4", id: false, force: :cascade do |t|
    t.integer "healthplanfid"
    t.integer "metrostatareafid"
    t.decimal "lives"
  end

  add_index "restriction_mv4", ["healthplanfid"], name: "restriction_mv41_idx", using: :btree
  add_index "restriction_mv4", ["metrostatareafid"], name: "restriction_mv42_idx", using: :btree

  create_table "restriction_mv5", id: false, force: :cascade do |t|
    t.integer "healthplanfid"
    t.integer "countyfid"
    t.decimal "lives"
  end

  add_index "restriction_mv5", ["countyfid"], name: "restriction_mv52_idx", using: :btree
  add_index "restriction_mv5", ["healthplanfid"], name: "restriction_mv51_idx", using: :btree

  create_table "restriction_mv6", id: false, force: :cascade do |t|
    t.integer "d_id"
    t.integer "pa_id"
    t.integer "ql_id"
    t.integer "st_id"
    t.integer "ro_id"
    t.string  "tier_codename",     limit: 20
    t.integer "hp_id"
    t.integer "healthplantypefid"
    t.integer "formularyfid"
    t.integer "drugfid"
  end

  add_index "restriction_mv6", ["drugfid"], name: "restriction_mv63_idx", using: :btree
  add_index "restriction_mv6", ["healthplantypefid"], name: "restriction_mv61_idx", using: :btree
  add_index "restriction_mv6", ["hp_id"], name: "restriction_mv62_idx", using: :btree

  create_table "restriction_report_criteria_groups", id: false, force: :cascade do |t|
    t.integer  "id",                     default: "nextval('restriction_report_criteria_groups_id_seq'::regclass)", null: false
    t.string   "name",       limit: 200,                                                                            null: false
    t.boolean  "is_active",              default: true,                                                             null: false
    t.datetime "created_at",             default: "now()",                                                          null: false
    t.datetime "updated_at",             default: "now()",                                                          null: false
  end

  create_table "restriction_report_drug_formulary", id: false, force: :cascade do |t|
    t.integer "restriction_report_drug_id",              null: false
    t.integer "healthplan_id",                           null: false
    t.string  "restriction_description",    limit: 2000
  end

  create_table "restriction_report_internal_comments", force: :cascade do |t|
    t.integer  "provider_id"
    t.string   "health_plan_type_list", limit: 100
    t.text     "comment"
    t.datetime "created_at",                        default: "now()"
    t.datetime "updated_at",                        default: "now()"
  end

  create_table "restriction_report_role_limitations", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "role_id"
    t.integer  "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restrictionreport", force: :cascade do |t|
    t.string   "name",               limit: 200,                 null: false
    t.integer  "sitefid",                                        null: false
    t.datetime "lastupdate",                                     null: false
    t.integer  "lastupdateffuserid",                             null: false
    t.boolean  "isactive",                       default: true,  null: false
    t.boolean  "publish",                        default: false
    t.boolean  "use_drug_strengths",             default: false
  end

  create_table "restrictionreport_abbrevs", force: :cascade do |t|
    t.integer  "reportfid",                   null: false
    t.string   "abbreviation",    limit: 255, null: false
    t.string   "definition",      limit: 500
    t.datetime "createtimestamp",             null: false
    t.datetime "modifytimestamp",             null: false
    t.integer  "createdby"
    t.integer  "modifiedby"
  end

  create_table "restrictionreportcriteria", force: :cascade do |t|
    t.integer  "reportfid",                                           null: false
    t.integer  "criteriafid",                                         null: false
    t.boolean  "isactive",                             default: true, null: false
    t.integer  "restriction_report_criteria_group_id"
    t.integer  "site_id"
    t.integer  "position"
    t.datetime "created_at"
    t.integer  "created_by"
    t.datetime "updated_at"
    t.integer  "updated_by"
  end

  create_table "restrictionreportdrug", force: :cascade do |t|
    t.integer "reportfid",                   null: false
    t.integer "drugfid",                     null: false
    t.integer "drugclassfid",                null: false
    t.boolean "isactive",     default: true, null: false
  end

  create_table "restrictionreportsite", force: :cascade do |t|
    t.integer "reportfid",                 limit: 8,                 null: false
    t.integer "sitefid",                   limit: 8,                 null: false
    t.boolean "isactive",                            default: true,  null: false
    t.boolean "is_super_user_access_only",           default: false, null: false
  end

  create_table "restrictions_custom_accounts", force: :cascade do |t|
    t.string   "account_name",     limit: 255
    t.string   "health_plan_ids",  limit: 1000
    t.boolean  "share_view"
    t.boolean  "share_edit"
    t.integer  "last_modified_by"
    t.integer  "site_id"
    t.integer  "site_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restrictions_custom_reports", force: :cascade do |t|
    t.string   "name",           limit: 100
    t.string   "report_type",    limit: 100
    t.integer  "site_id",                      null: false
    t.integer  "user_id",                      null: false
    t.string   "marshaled_data", limit: 10000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restrictions_data_update_tasks", force: :cascade do |t|
    t.text     "health_plan_id_list"
    t.text     "drug_id_list"
    t.boolean  "is_provider_change",  default: false, null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "restrictions_data_update_tasks", ["started_at"], name: "index_restrictions_data_update_tasks_on_started_at", using: :btree

  create_table "roche_admin_msa_name_logs", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "metro_stat_area_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roche_admin_msa_name_notes", force: :cascade do |t|
    t.text     "description"
    t.integer  "created_by"
    t.integer  "metro_stat_area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roche_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2009-01-26 19:03:30'
    t.datetime "updated_at",                              default: '2009-01-26 19:03:30'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
    t.integer  "copay_option",                            default: 0
    t.integer  "analytics_header_type",                   default: 0,                     null: false
    t.integer  "clinical_message",                        default: 0,                     null: false
    t.integer  "msa_id"
    t.integer  "county_id"
    t.boolean  "from_ipad",                               default: false
    t.string   "mobile_version",              limit: 32,  default: ""
    t.string   "ws_source",                   limit: 32,  default: ""
  end

  add_index "roche_formularies", ["drug_class_id"], name: "roche_formularies_drug_class_id_idx", using: :btree
  add_index "roche_formularies", ["site_user_id"], name: "roche_formularies_site_user_id_idx", using: :btree
  add_index "roche_formularies", ["state_id"], name: "roche_formularies_state_id_idx", using: :btree
  add_index "roche_formularies", ["template"], name: "roche_formularies_template_idx", using: :btree

  create_table "roche_formulary_label_items", force: :cascade do |t|
    t.integer  "roche_formulary_label_id"
    t.integer  "roche_formulary_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roche_formulary_labels", force: :cascade do |t|
    t.integer  "ff_publisher_template_id"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roche_iphone_cache_updates", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roche_iphone_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_key", limit: 200
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roche_iphone_web_service_requests", force: :cascade do |t|
    t.string   "application_key", limit: 255
    t.string   "session_key",     limit: 255
    t.integer  "user_id"
    t.string   "controller",      limit: 255
    t.string   "action",          limit: 255
    t.string   "ip_address",      limit: 255
    t.string   "udid",            limit: 255
    t.text     "request_uri"
    t.string   "os_version",      limit: 255
    t.string   "device_model",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roche_mobile_request_logs", force: :cascade do |t|
    t.string   "udid",            limit: 255
    t.string   "os_version",      limit: 255
    t.string   "application_key", limit: 255
    t.string   "session_key",     limit: 255
    t.string   "device_model",    limit: 255
    t.string   "url",             limit: 1000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roche_mobile_request_logs", ["udid"], name: "index_roche_mobile_request_logs_on_udid", using: :btree

  create_table "roche_mobile_user_sessions", force: :cascade do |t|
    t.string   "session_key",      limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_accessed_at"
  end

  add_index "roche_mobile_user_sessions", ["session_key"], name: "index_roche_mobile_user_sessions_on_session_key", using: :btree
  add_index "roche_mobile_user_sessions", ["user_id"], name: "index_roche_mobile_user_sessions_on_user_id", using: :btree

  create_table "roche_msa_names", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",             default: '2014-01-22 08:48:42'
    t.datetime "updated_at",             default: '2014-01-22 08:48:42'
    t.integer  "msa_id"
    t.string   "name",       limit: 100
  end

  create_table "roche_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "formulary_table_name", limit: 255
    t.integer  "formulary_table_id"
    t.string   "environment",          limit: 255
    t.string   "file_name",            limit: 255
    t.string   "pdf_unique_id",        limit: 255
  end

  add_index "roche_pdf_accesses", ["formulary_table_id"], name: "roche_pdf_accesses_formulary_table_id_idx", using: :btree
  add_index "roche_pdf_accesses", ["user_id"], name: "roche_pdf_accesses_user_id_idx", using: :btree

  create_table "roche_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "site_user_id"
    t.datetime "created_at",    default: '2009-01-26 19:03:31'
    t.datetime "updated_at",    default: '2009-01-26 19:03:31'
    t.boolean  "exclude",       default: false
    t.boolean  "bold",          default: false
    t.boolean  "highlight",     default: false
  end

  add_index "roche_plan_drug_settings", ["drug_id"], name: "roche_plan_drug_settings_drug_id_idx", using: :btree
  add_index "roche_plan_drug_settings", ["healthplan_id"], name: "roche_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "roche_plan_drug_settings", ["site_user_id"], name: "roche_plan_drug_settings_site_user_id_idx", using: :btree
  add_index "roche_plan_drug_settings", ["state_id"], name: "roche_plan_drug_settings_state_id_idx", using: :btree

  create_table "roche_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at",         default: '2009-01-26 19:03:31'
    t.datetime "updated_at",         default: '2009-01-26 19:03:31'
    t.integer  "updated_by_user_id"
  end

  create_table "roche_roles", force: :cascade do |t|
    t.string   "role",                limit: 200
    t.string   "description",         limit: 200
    t.integer  "adminonly",                       default: 0
    t.integer  "requires_approval",               default: 0
    t.integer  "formulary_tables",                default: 0
    t.integer  "analytics",                       default: 0
    t.integer  "active",                          default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "publisher_reporting",             default: false
    t.integer  "accounts",                        default: 0
    t.integer  "restrictions",                    default: 0
    t.integer  "view_formulary_data",             default: 0
  end

  create_table "roche_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: '2009-01-26 19:03:31'
    t.datetime "updated_at",                      default: '2009-01-26 19:03:31'
  end

  create_table "roche_user_logins", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roche_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp"
    t.datetime "last_accessed_timestamp"
  end

  add_index "roche_user_sessions", ["user_id"], name: "roche_user_sessions_user_id_idx", using: :btree

  create_table "roche_users", force: :cascade do |t|
    t.string   "login",              limit: 255
    t.string   "email",              limit: 255
    t.string   "password",           limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",         limit: 200
    t.string   "last_name",          limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                         default: 0
    t.integer  "approved",                       default: 0
    t.string   "activationkey",      limit: 50
    t.string   "password_salt",      limit: 255
    t.string   "password_hash",      limit: 255
    t.string   "password_reset_key", limit: 255
    t.datetime "password_set_at"
  end

  create_table "roche_users_import_tmp", id: false, force: :cascade do |t|
    t.string "email",      limit: 200, null: false
    t.string "last_name",  limit: 200, null: false
    t.string "first_name", limit: 200, null: false
    t.string "role_desc",  limit: 200
  end

  add_index "roche_users_import_tmp", ["email"], name: "roche_users_import_tmp_email_key", unique: true, using: :btree

  create_table "role_assignment_changes", force: :cascade do |t|
    t.integer  "ff_site_id"
    t.integer  "site_user_id"
    t.integer  "old_role_id"
    t.integer  "new_role_id"
    t.integer  "changed_by_user_id"
    t.text     "comments"
    t.integer  "comment_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rollup_lives_county", id: false, force: :cascade do |t|
    t.integer "healthplanfid"
    t.integer "countyfid"
    t.decimal "lives"
  end

  add_index "rollup_lives_county", ["countyfid"], name: "rollup_lives_county_idx", using: :btree

  create_table "rollup_lives_metro", id: false, force: :cascade do |t|
    t.integer "healthplanfid"
    t.integer "metrostatareafid"
    t.decimal "lives"
  end

  add_index "rollup_lives_metro", ["metrostatareafid"], name: "rollup_lives_metro_idx", using: :btree

  create_table "rollup_lives_state", id: false, force: :cascade do |t|
    t.integer "healthplanfid"
    t.integer "statefid"
    t.decimal "lives"
  end

  add_index "rollup_lives_state", ["statefid"], name: "rollup_lives_state_idx", using: :btree

  create_table "sa_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "bms_formulary_id"
    t.boolean  "copied_to_bms",                           default: false
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: "now()"
    t.datetime "updated_at",                              default: "now()"
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.integer  "county_id"
    t.integer  "msa_id"
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
    t.integer  "custom_header_option",                    default: 1
    t.boolean  "include_state_percentage",                default: true
  end

  add_index "sa_formularies", ["drug_class_id"], name: "sa_formularies_drug_class_id_idx", using: :btree
  add_index "sa_formularies", ["site_user_id"], name: "sa_formularies_site_user_id_idx", using: :btree
  add_index "sa_formularies", ["state_id"], name: "sa_formularies_state_id_idx", using: :btree
  add_index "sa_formularies", ["template"], name: "sa_formularies_template_idx", using: :btree

  create_table "sa_formulary_approvals", force: :cascade do |t|
    t.integer  "formulary_id"
    t.integer  "user_id"
    t.datetime "created_at",               default: "now()"
    t.datetime "updated_at",               default: "now()"
    t.string   "name",         limit: 100
    t.string   "company",      limit: 100
  end

  create_table "sa_formulary_exports", force: :cascade do |t|
    t.integer  "formulary_id"
    t.datetime "created_at",               default: "now()"
    t.string   "user_name",    limit: 255
    t.string   "territory",    limit: 255
  end

  create_table "sa_msa_names", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",             default: "now()"
    t.datetime "updated_at",             default: "now()"
    t.integer  "msa_id"
    t.string   "name",       limit: 100
  end

  create_table "sa_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "user_id"
    t.datetime "created_at",    default: "now()"
    t.datetime "updated_at",    default: "now()"
    t.boolean  "exclude",       default: false
    t.boolean  "bold",          default: false
    t.boolean  "highlight",     default: false
  end

  add_index "sa_plan_drug_settings", ["drug_id"], name: "sa_plan_drug_settings_drug_id_idx", using: :btree
  add_index "sa_plan_drug_settings", ["healthplan_id"], name: "sa_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "sa_plan_drug_settings", ["state_id"], name: "sa_plan_drug_settings_state_id_idx", using: :btree
  add_index "sa_plan_drug_settings", ["user_id"], name: "sa_plan_drug_settings_site_user_id_idx", using: :btree

  create_table "sa_plan_names", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                default: "now()"
    t.datetime "updated_at",                default: "now()"
    t.integer  "healthplan_id"
    t.string   "name",          limit: 100
  end

  create_table "sa_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at",         default: "now()"
    t.datetime "updated_at",         default: "now()"
    t.integer  "updated_by_user_id"
  end

  add_index "sa_plan_tier_labels", ["healthplan_id"], name: "sa_plan_tier_labels_healthplan_id_idx", using: :btree
  add_index "sa_plan_tier_labels", ["tier_id"], name: "sa_plan_tier_labels_tier_id_idx", using: :btree
  add_index "sa_plan_tier_labels", ["tier_label_id"], name: "sa_plan_tier_labels_tier_label_id_idx", using: :btree

  create_table "sa_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.datetime "created_at",                    default: "now()"
    t.datetime "updated_at",                    default: "now()"
  end

  create_table "sa_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "sa_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: "now()"
    t.datetime "last_accessed_timestamp",             default: "now()"
  end

  create_table "sa_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at",                default: "now()"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at",                default: "now()"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "salix_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2010-12-22 18:14:34'
    t.datetime "updated_at",                              default: '2010-12-22 18:14:34'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "salix_formularies", ["drug_class_id"], name: "salix_formularies_drug_class_id_idx", using: :btree
  add_index "salix_formularies", ["site_user_id"], name: "salix_formularies_site_user_id_idx", using: :btree
  add_index "salix_formularies", ["state_id"], name: "salix_formularies_state_id_idx", using: :btree
  add_index "salix_formularies", ["template"], name: "salix_formularies_template_idx", using: :btree

  create_table "salix_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "publisher_formulary_name", limit: 255
    t.integer  "publisher_formulary_id"
    t.string   "environment",              limit: 255
    t.string   "file_name",                limit: 255
    t.string   "pdf_unique_id",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salix_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "salix_plan_drug_options", ["created_by"], name: "salix_plan_drug_options_created_by_idx", using: :btree
  add_index "salix_plan_drug_options", ["updated_by"], name: "salix_plan_drug_options_updated_by_idx", using: :btree

  create_table "salix_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "salix_plan_drug_settings", ["created_by"], name: "salix_plan_drug_settings_created_by_idx", using: :btree
  add_index "salix_plan_drug_settings", ["drug_id"], name: "salix_plan_drug_settings_drug_id_idx", using: :btree
  add_index "salix_plan_drug_settings", ["healthplan_id"], name: "salix_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "salix_plan_drug_settings", ["plan_drug_option_id"], name: "salix_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "salix_plan_drug_settings", ["state_id"], name: "salix_plan_drug_settings_state_id_idx", using: :btree
  add_index "salix_plan_drug_settings", ["updated_by"], name: "salix_plan_drug_settings_updated_by_idx", using: :btree

  create_table "salix_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salix_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salix_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "salix_publisher_activity_report_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salix_publisher_activity_report_states", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salix_publisher_activity_report_templates", force: :cascade do |t|
    t.integer  "template_id"
    t.string   "template_type",                limit: 255
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salix_publisher_activity_reports", force: :cascade do |t|
    t.boolean  "use_preset_date"
    t.string   "preset_date",     limit: 255
    t.date     "end_date"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_national"
  end

  create_table "salix_publisher_formularies", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.string   "current_step",                    limit: 255
    t.string   "name",                            limit: 255
    t.string   "competitor_drug_ids",             limit: 255, default: ""
    t.integer  "state_id"
    t.integer  "msa_id"
    t.integer  "county_id"
    t.string   "health_plan_types",               limit: 255, default: ""
    t.string   "commercial_health_plan_ids",      limit: 255, default: ""
    t.string   "medicare_health_plan_ids",        limit: 255, default: ""
    t.string   "medicaid_health_plan_ids",        limit: 255, default: ""
    t.string   "highlighted_health_plan_ids",     limit: 255, default: ""
    t.string   "bolded_health_plan_ids",          limit: 255, default: ""
    t.boolean  "display_copay",                               default: false
    t.boolean  "display_restrictions",                        default: true
    t.integer  "version"
    t.boolean  "is_active",                                   default: true
    t.boolean  "is_published",                                default: false
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "highlight_spotlight_drug_column",             default: false
    t.string   "header_option",                   limit: 255
    t.string   "header_info",                     limit: 255
  end

  create_table "salix_publisher_templates", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "klass_name",                limit: 255
    t.string   "spotlight_drug_ids",        limit: 255, default: ""
    t.string   "competitor_drug_ids",       limit: 255, default: ""
    t.integer  "health_plan_count_min"
    t.integer  "health_plan_count_max"
    t.integer  "competitor_drug_count_min"
    t.integer  "competitor_drug_count_max"
    t.string   "allowed_role_ids",          limit: 255, default: ""
    t.boolean  "is_active",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activation_change_comment", limit: 255
    t.boolean  "is_html_pdf",                           default: true
  end

  create_table "salix_roles", force: :cascade do |t|
    t.string   "role",                limit: 200
    t.string   "description",         limit: 200
    t.integer  "adminonly",                       default: 0
    t.integer  "requires_approval",               default: 0
    t.integer  "formulary_tables",                default: 0
    t.integer  "analytics",                       default: 0
    t.integer  "active",                          default: 1
    t.boolean  "is_super_user",                   default: false
    t.datetime "created_at",                      default: '2010-12-22 18:14:33'
    t.datetime "updated_at",                      default: '2010-12-22 18:14:33'
    t.boolean  "publisher_reporting"
  end

  create_table "salix_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "salix_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-12-22 18:14:34'
    t.datetime "last_accessed_timestamp",             default: '2010-12-22 18:14:34'
  end

  create_table "salix_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "sandozrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "sandozuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "sandozuser", ["email"], name: "sandozuser_email_key", unique: true, using: :btree

  create_table "sandozusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "search_suggestions", force: :cascade do |t|
    t.string   "term"
    t.integer  "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sepracor_admin_plan_name_logs", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "health_plan_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sepracor_admin_plan_name_notes", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "health_plan_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sepracor_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2009-11-27 11:57:02'
    t.datetime "updated_at",                              default: '2009-11-27 11:57:02'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "sepracor_formularies", ["drug_class_id"], name: "sepracor_formularies_drug_class_id_idx", using: :btree
  add_index "sepracor_formularies", ["site_user_id"], name: "sepracor_formularies_site_user_id_idx", using: :btree
  add_index "sepracor_formularies", ["state_id"], name: "sepracor_formularies_state_id_idx", using: :btree
  add_index "sepracor_formularies", ["template"], name: "sepracor_formularies_template_idx", using: :btree

  create_table "sepracor_mobile_request_logs", force: :cascade do |t|
    t.string   "udid",            limit: 255
    t.string   "os_version",      limit: 255
    t.string   "application_key", limit: 255
    t.string   "session_key",     limit: 255
    t.string   "device_model",    limit: 255
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sepracor_mobile_request_logs", ["udid"], name: "index_sepracor_mobile_request_logs_on_udid", using: :btree

  create_table "sepracor_mobile_user_sessions", force: :cascade do |t|
    t.string   "session_key",      limit: 255
    t.integer  "user_id"
    t.datetime "last_accessed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sepracor_mobile_user_sessions", ["session_key"], name: "index_sepracor_mobile_user_sessions_on_session_key", using: :btree
  add_index "sepracor_mobile_user_sessions", ["user_id"], name: "index_sepracor_mobile_user_sessions_on_user_id", using: :btree

  create_table "sepracor_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "publisher_formulary_name", limit: 255
    t.integer  "publisher_formulary_id"
    t.string   "environment",              limit: 255
    t.string   "file_name",                limit: 255
    t.string   "pdf_unique_id",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sepracor_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "sepracor_plan_drug_options", ["created_by"], name: "sepracor_plan_drug_options_created_by_idx", using: :btree
  add_index "sepracor_plan_drug_options", ["updated_by"], name: "sepracor_plan_drug_options_updated_by_idx", using: :btree

  create_table "sepracor_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "sepracor_plan_drug_settings", ["created_by"], name: "sepracor_plan_drug_settings_created_by_idx", using: :btree
  add_index "sepracor_plan_drug_settings", ["drug_id"], name: "sepracor_plan_drug_settings_drug_id_idx", using: :btree
  add_index "sepracor_plan_drug_settings", ["healthplan_id"], name: "sepracor_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "sepracor_plan_drug_settings", ["plan_drug_option_id"], name: "sepracor_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "sepracor_plan_drug_settings", ["state_id"], name: "sepracor_plan_drug_settings_state_id_idx", using: :btree
  add_index "sepracor_plan_drug_settings", ["updated_by"], name: "sepracor_plan_drug_settings_updated_by_idx", using: :btree

  create_table "sepracor_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sepracor_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sepracor_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "sepracor_publisher_formularies", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.string   "current_step",                   limit: 255
    t.string   "name",                           limit: 255
    t.string   "competitor_drug_ids",            limit: 255, default: ""
    t.integer  "state_id"
    t.integer  "msa_id"
    t.string   "health_plan_types",              limit: 255, default: ""
    t.string   "commercial_health_plan_ids",     limit: 255, default: ""
    t.string   "medicare_health_plan_ids",       limit: 255, default: ""
    t.string   "medicaid_health_plan_ids",       limit: 255, default: ""
    t.string   "employer_group_health_plan_ids", limit: 255, default: ""
    t.string   "pbm_health_plan_ids",            limit: 255, default: ""
    t.string   "doctor_name",                    limit: 255
    t.string   "rep_name",                       limit: 255
    t.integer  "version"
    t.boolean  "display_copay",                              default: false
    t.boolean  "display_covered_lives",                      default: false
    t.boolean  "is_active",                                  default: true
    t.boolean  "is_published",                               default: false
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "highlighted_health_plan_ids",    limit: 255, default: ""
    t.string   "bolded_health_plan_ids",         limit: 255, default: ""
    t.string   "header_option_one",              limit: 255
    t.string   "header_option_two",              limit: 255
  end

  create_table "sepracor_publisher_templates", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "klass_name",                limit: 255
    t.string   "spotlight_drug_ids",        limit: 255, default: ""
    t.string   "competitor_drug_ids",       limit: 255, default: ""
    t.integer  "health_plan_count_min"
    t.integer  "health_plan_count_max"
    t.integer  "competitor_drug_count_min"
    t.integer  "competitor_drug_count_max"
    t.string   "allowed_role_ids",          limit: 255, default: ""
    t.boolean  "is_active",                             default: true
    t.integer  "drug_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activation_change_comment", limit: 255
  end

  create_table "sepracor_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.datetime "created_at",                    default: '2009-11-27 11:57:02'
    t.datetime "updated_at",                    default: '2009-11-27 11:57:02'
    t.integer  "accounts",                      default: 0
    t.integer  "restrictions",                  default: 0
    t.boolean  "is_super_user",                 default: false
    t.boolean  "alerts",                        default: false
  end

  create_table "sepracor_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "sepracor_user_services_accounts", force: :cascade do |t|
    t.integer "site_user_service_id"
    t.integer "analytics_key_account_id"
  end

  create_table "sepracor_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2009-11-27 11:57:02'
    t.datetime "last_accessed_timestamp",             default: '2009-11-27 11:57:02'
  end

  create_table "sepracor_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "sepracoruseralert", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.integer  "legacyfid"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "archived_at"
  end

  create_table "sepracoruserservice", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid",      null: false
    t.integer "drugclassfid"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "shire_batch_formularies", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "dma_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shire_publisher_batch_job_id"
  end

  add_index "shire_batch_formularies", ["dma_id"], name: "index_shire_batch_formularies_on_dma_id", using: :btree
  add_index "shire_batch_formularies", ["state_id"], name: "index_shire_batch_formularies_on_state_id", using: :btree

  create_table "shire_batch_job_queue_entries", force: :cascade do |t|
    t.integer  "batch_job_id"
    t.integer  "queued_by_id"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shire_dma_copay_approval", force: :cascade do |t|
    t.integer  "dma_id",           limit: 8
    t.integer  "drug_id",          limit: 8
    t.decimal  "copay"
    t.decimal  "approval_percent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "wk_date",                    default: "now()"
  end

  add_index "shire_dma_copay_approval", ["dma_id"], name: "shire_dma_copay_approval_dma_id_idx", using: :btree
  add_index "shire_dma_copay_approval", ["drug_id"], name: "shire_dma_copay_approval_drug_id_idx", using: :btree

  create_table "shire_dma_name_logs", force: :cascade do |t|
    t.integer  "site_dma_name_id"
    t.text     "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shire_dma_names", force: :cascade do |t|
    t.integer  "dma_id",        limit: 8
    t.string   "site_name",     limit: 100
    t.integer  "active",        limit: 8,   default: 1
    t.datetime "created_at",                default: "now()"
    t.datetime "updated_at",                default: "now()"
    t.integer  "updated_by_id", limit: 8
    t.integer  "state_id"
  end

  create_table "shire_dma_provider_temp", force: :cascade do |t|
    t.string   "session_id",     limit: 100
    t.integer  "dma_id"
    t.integer  "provider_id"
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "plan_type"
    t.integer  "plan_excluded",              default: 0
    t.string   "drug_status",    limit: 100
    t.integer  "drug_tier"
    t.string   "drug_pa",        limit: 2
    t.string   "drug_ql",        limit: 2
    t.string   "drug_st",        limit: 2
    t.string   "drug_or",        limit: 2
    t.float    "plan_lives"
    t.float    "provider_lives"
    t.string   "reason_code",    limit: 10
    t.datetime "created_at",                 default: "now()"
  end

  add_index "shire_dma_provider_temp", ["dma_id"], name: "shire_dma_provider_temp_dma_id_idx", using: :btree
  add_index "shire_dma_provider_temp", ["drug_id"], name: "shire_dma_provider_temp_drug_id_idx", using: :btree
  add_index "shire_dma_provider_temp", ["healthplan_id"], name: "shire_dma_provider_temp_healthplan_id_idx", using: :btree
  add_index "shire_dma_provider_temp", ["provider_id"], name: "shire_dma_provider_temp_provider_id_idx", using: :btree

  create_table "shire_formularies", force: :cascade do |t|
    t.integer  "active",                                   default: 1
    t.integer  "published",                                default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                               default: "now()"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.string   "title",                        limit: 100
    t.string   "version",                      limit: 100
    t.integer  "version_number",                           default: 0
    t.string   "template",                     limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.integer  "dma_id"
    t.string   "geographic_area",              limit: 255
    t.string   "spotlight_drug_list",          limit: 255
    t.string   "competitor_drug_list",         limit: 255
    t.string   "provider_order_list",          limit: 255
    t.string   "plan_order_list",              limit: 255
    t.string   "rep_name",                     limit: 255
    t.boolean  "display_restrictions",                     default: false
    t.integer  "shire_publisher_formulary_id"
  end

  add_index "shire_formularies", ["dma_id"], name: "shire_formularies_dma_id_idx", using: :btree
  add_index "shire_formularies", ["drug_class_id"], name: "shire_formularies_drug_class_id_idx", using: :btree
  add_index "shire_formularies", ["site_user_id"], name: "shire_formularies_site_user_id_idx", using: :btree
  add_index "shire_formularies", ["state_id"], name: "shire_formularies_state_id_idx", using: :btree
  add_index "shire_formularies", ["template"], name: "shire_formularies_template_idx", using: :btree

  create_table "shire_formulary_order_addresses", force: :cascade do |t|
    t.integer  "site_user_id"
    t.integer  "site_formulary_order_id"
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "address_1",               limit: 255
    t.string   "address_2",               limit: 255
    t.string   "city",                    limit: 255
    t.integer  "state_id"
    t.string   "zip_code",                limit: 255
    t.string   "telephone_1",             limit: 255
    t.string   "telephone_2",             limit: 255
    t.string   "telephone_3",             limit: 255
    t.string   "telephone_4",             limit: 255
    t.string   "email",                   limit: 255
    t.boolean  "store",                               default: false
    t.datetime "created_at"
    t.integer  "lock_version",                        default: 0
  end

  create_table "shire_formulary_order_defaults", force: :cascade do |t|
    t.integer  "site_role_id"
    t.integer  "drug_id"
    t.integer  "quantity"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.integer  "lock_version",             default: 0
    t.integer  "ff_publisher_template_id",             null: false
  end

  create_table "shire_formulary_order_users", force: :cascade do |t|
    t.integer  "site_user_id"
    t.integer  "drug_id"
    t.integer  "quantity"
    t.datetime "modified_at"
    t.integer  "modified_by"
    t.integer  "lock_version", default: 0
  end

  create_table "shire_formulary_orders", force: :cascade do |t|
    t.integer  "site_user_id"
    t.integer  "site_formulary_id"
    t.integer  "lock_version",                    default: 0
    t.boolean  "order_sent",                      default: false, null: false
    t.string   "pdf_file",          limit: 255,                   null: false
    t.integer  "quantity"
    t.boolean  "special_dl",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pdf_ftp",                         default: false, null: false
    t.boolean  "txt_ftp",                         default: false, null: false
    t.string   "order_text",        limit: 65535
  end

  create_table "shire_plan_exclusions", force: :cascade do |t|
    t.boolean  "active",        default: true
    t.integer  "drugclass_id"
    t.integer  "drug_id"
    t.integer  "provider_id"
    t.integer  "healthplan_id"
    t.integer  "site_user_id"
    t.boolean  "exclude_batch", default: true
    t.boolean  "exclude_table", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shire_plan_tier_label_change_logs", force: :cascade do |t|
    t.string   "from_label_text",                limit: 255
    t.string   "to_label_text",                  limit: 255
    t.text     "from_note_text"
    t.text     "to_note_text"
    t.string   "editing_user_id",                limit: 255
    t.string   "editing_user_email",             limit: 255
    t.datetime "created_at"
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "drug_id"
    t.integer  "site_static_publisher_sheet_id"
  end

  create_table "shire_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
    t.integer  "publisher_template_id"
    t.integer  "drug_id"
  end

  create_table "shire_plan_tier_notes", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.text     "note_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "drug_id"
    t.integer  "site_static_publisher_sheet_id"
  end

  create_table "shire_preferred_provider_inclusions", force: :cascade do |t|
    t.boolean  "active",             default: true
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "shire_provider_custom", force: :cascade do |t|
    t.integer  "provider_id"
    t.string   "name",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "shire_provider_exclusions", force: :cascade do |t|
    t.boolean  "active",             default: true
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "shire_publisher_batch_jobs", force: :cascade do |t|
    t.string   "job_name",          limit: 255
    t.string   "archive_file_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "template",          limit: 255
  end

  create_table "shire_publisher_formularies", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.string   "name",                     limit: 255
    t.integer  "created_by_id"
    t.boolean  "is_active",                            default: true
    t.boolean  "is_published",                         default: false
    t.string   "current_step",             limit: 255
    t.integer  "version"
    t.integer  "state_id"
    t.string   "health_plan_types",        limit: 255, default: ""
    t.string   "geographic_customization", limit: 255, default: ""
    t.string   "physician_customization",  limit: 255, default: ""
    t.integer  "header_type",                          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "single_plan"
    t.integer  "dma_id"
    t.string   "provider_ids",             limit: 255
  end

  create_table "shire_publisher_templates", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "klass_name",                limit: 255
    t.string   "spotlight_drug_ids",        limit: 255, default: ""
    t.string   "competitor_drug_ids",       limit: 255, default: ""
    t.integer  "health_plan_count_min"
    t.integer  "health_plan_count_max"
    t.integer  "competitor_drug_count_min"
    t.integer  "competitor_drug_count_max"
    t.string   "allowed_role_ids",          limit: 255, default: ""
    t.boolean  "is_active",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_generic_template",                   default: false
    t.integer  "ff_publisher_template_id"
  end

  create_table "shire_roles", force: :cascade do |t|
    t.string   "role",                limit: 200
    t.string   "description",         limit: 200
    t.integer  "adminonly",           limit: 8,   default: 0
    t.integer  "requiresapproval",    limit: 8,   default: 0
    t.integer  "createtable",         limit: 8,   default: 0
    t.integer  "analytics",           limit: 8,   default: 0
    t.integer  "active",              limit: 8,   default: 1
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "myprofile",           limit: 8,   default: 1
    t.integer  "reporting",           limit: 8,   default: 1
    t.integer  "request_account",     limit: 8,   default: 0,     null: false
    t.integer  "manage_users",                    default: 0,     null: false
    t.integer  "admin_tab",                       default: 0,     null: false
    t.integer  "view_formulary_data",             default: 0,     null: false
    t.integer  "search_tables",                   default: 0
    t.boolean  "is_super_user",                   default: false
    t.integer  "restrictions",                    default: 0
  end

  create_table "shire_static_publisher_sheets", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "filename",              limit: 255
    t.integer  "uploaded_by_user_id"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publisher_template_id"
    t.boolean  "active",                            default: true
    t.string   "tier_status_label",     limit: 255
    t.string   "printer_document_id",   limit: 255
  end

  create_table "shire_tier_labels", force: :cascade do |t|
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
    t.string   "pdf_label",           limit: 255
  end

  create_table "shire_users", force: :cascade do |t|
    t.string   "login",            limit: 255
    t.string   "email",            limit: 255
    t.string   "password",         limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",       limit: 200
    t.string   "last_name",        limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                       default: 0
    t.integer  "approved",                     default: 0
    t.integer  "alerts",                       default: 0
    t.string   "activationkey",    limit: 50
    t.boolean  "password_expired",             default: false, null: false
    t.datetime "last_roster_date"
    t.datetime "renewed_at"
    t.string   "activated_by",     limit: 255
    t.string   "deactivated_by",   limit: 255
    t.datetime "deactivated_at"
  end

  create_table "shire_view_active_health_plans_dma_lives", id: false, force: :cascade do |t|
    t.integer "health_plan_id"
    t.integer "dma_id"
    t.decimal "lives"
  end

  add_index "shire_view_active_health_plans_dma_lives", ["health_plan_id", "dma_id"], name: "shire_view_active_health_plans_dma_lives_search_ind", using: :btree

  create_table "shire_view_active_health_plans_state_lives", id: false, force: :cascade do |t|
    t.integer "state_id"
    t.integer "health_plan_id"
    t.decimal "lives"
  end

  add_index "shire_view_active_health_plans_state_lives", ["state_id", "health_plan_id"], name: "shire_view_active_health_plans_state_lives_search_ind", using: :btree

  create_table "shireusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "site_notices", force: :cascade do |t|
    t.string  "message",           limit: 1000
    t.integer "display_end_year"
    t.integer "display_end_month"
    t.integer "display_end_day"
    t.integer "display_end_hour"
    t.boolean "is_active"
  end

  create_table "site_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "active",                  default: 0
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spatial_ref_sys", primary_key: "srid", force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

  create_table "state", force: :cascade do |t|
    t.boolean "isactive",                        null: false
    t.string  "name",                limit: 255, null: false
    t.string  "abbreviation",        limit: 10,  null: false
    t.integer "countryfid",                      null: false
    t.string  "legacycolumnname",    limit: 10
    t.integer "azbusinesscenterfid"
    t.integer "population"
    t.boolean "formulary_state"
    t.integer "fipsid"
    t.integer "medicare_lis_lives"
  end

  add_index "state", ["abbreviation"], name: "state_abbreviation_idx", unique: true, using: :btree
  add_index "state", ["countryfid", "abbreviation"], name: "state_countryfid_key1", unique: true, using: :btree
  add_index "state", ["countryfid", "name"], name: "state_countryfid_key", unique: true, using: :btree

# Could not dump table "state_map_regions" because of following StandardError
#   Unknown type 'geometry' for column 'geom'

  create_table "state_maps", force: :cascade do |t|
    t.integer  "state_id"
    t.boolean  "tiny",       default: false
    t.integer  "center_x",   default: 0,     null: false
    t.integer  "center_y",   default: 0,     null: false
    t.integer  "offset_x",   default: 0,     null: false
    t.integer  "offset_y",   default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "scale",      default: 1.0,   null: false
  end

  create_table "state_metrostatarea", force: :cascade do |t|
    t.integer "statefid"
    t.integer "metrostatareafid"
  end

  add_index "state_metrostatarea", ["metrostatareafid"], name: "metrostatareafid_idx", using: :btree
  add_index "state_metrostatarea", ["statefid", "metrostatareafid"], name: "statefid_metrostatareafid_idx", using: :btree
  add_index "state_metrostatarea", ["statefid"], name: "statefid_idx", using: :btree

  create_table "statelives_batch", force: :cascade do |t|
    t.integer  "providerfid",                      null: false
    t.integer  "statefid",                         null: false
    t.integer  "lives",                            null: false
    t.integer  "lives_netoutmedicare", default: 0, null: false
    t.datetime "modifytimestamp",                  null: false
  end

  create_table "stirling_ce", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "criteriafid"
    t.text     "value_text"
    t.decimal  "value_numeric_start"
    t.integer  "value_numeric_end"
    t.string   "value_units",         limit: 255
    t.datetime "lastupdate"
    t.integer  "lastupdateffuserid"
    t.boolean  "isactive"
    t.string   "start_value_units",   limit: 255
  end

  create_table "stirling_ce2", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "criteriafid"
    t.text     "value_text"
    t.decimal  "value_numeric_start"
    t.integer  "value_numeric_end"
    t.string   "value_units",         limit: 255
    t.datetime "lastupdate"
    t.integer  "lastupdateffuserid"
    t.boolean  "isactive"
    t.string   "start_value_units",   limit: 255
  end

  create_table "stirling_feq_restore", id: false, force: :cascade do |t|
    t.integer "feqfid"
  end

  add_index "stirling_feq_restore", ["feqfid"], name: "stirling_feq_restore_idx", unique: true, using: :btree

  create_table "stirling_feqce", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "feqfid"
    t.integer  "criteriaentryfid"
    t.integer  "drugclassfid"
    t.text     "notes"
    t.datetime "lastupdate"
    t.integer  "lastupdateffuserid"
    t.integer  "healthplanfid"
    t.string   "restrictionflag",          limit: 5
    t.integer  "reportfid"
    t.text     "restriction_details"
    t.integer  "providerfid"
    t.text     "internal_comments_unused"
    t.boolean  "feqfid_is_updated"
  end

  create_table "stirling_ql", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "drug_strength_id"
    t.integer "feq_criteria_entry_id"
    t.boolean "is_restricted"
    t.text    "comment"
    t.float   "dosage_quantity_1"
    t.string  "dosage_unit_1",         limit: 255
    t.float   "period_quantity_1"
    t.string  "period_unit_1",         limit: 255
    t.float   "dosage_quantity_2"
    t.string  "dosage_unit_2",         limit: 255
    t.float   "period_quantity_2"
    t.string  "period_unit_2",         limit: 255
    t.float   "daily_limit"
  end

  create_table "strativa_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2009-12-21 15:24:37'
    t.datetime "updated_at",                              default: '2009-12-21 15:24:37'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "strativa_formularies", ["drug_class_id"], name: "strativa_formularies_drug_class_id_idx", using: :btree
  add_index "strativa_formularies", ["site_user_id"], name: "strativa_formularies_site_user_id_idx", using: :btree
  add_index "strativa_formularies", ["state_id"], name: "strativa_formularies_state_id_idx", using: :btree
  add_index "strativa_formularies", ["template"], name: "strativa_formularies_template_idx", using: :btree

  create_table "strativa_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "strativa_plan_drug_options", ["created_by"], name: "strativa_plan_drug_options_created_by_idx", using: :btree
  add_index "strativa_plan_drug_options", ["updated_by"], name: "strativa_plan_drug_options_updated_by_idx", using: :btree

  create_table "strativa_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "strativa_plan_drug_settings", ["created_by"], name: "strativa_plan_drug_settings_created_by_idx", using: :btree
  add_index "strativa_plan_drug_settings", ["drug_id"], name: "strativa_plan_drug_settings_drug_id_idx", using: :btree
  add_index "strativa_plan_drug_settings", ["healthplan_id"], name: "strativa_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "strativa_plan_drug_settings", ["plan_drug_option_id"], name: "strativa_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "strativa_plan_drug_settings", ["state_id"], name: "strativa_plan_drug_settings_state_id_idx", using: :btree
  add_index "strativa_plan_drug_settings", ["updated_by"], name: "strativa_plan_drug_settings_updated_by_idx", using: :btree

  create_table "strativa_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "strativa_roles", force: :cascade do |t|
    t.string   "role",              limit: 200
    t.string   "description",       limit: 200
    t.integer  "adminonly",                     default: 0
    t.integer  "requires_approval",             default: 0
    t.integer  "formulary_tables",              default: 0
    t.integer  "analytics",                     default: 0
    t.integer  "active",                        default: 1
    t.datetime "created_at",                    default: '2009-12-21 15:24:37'
    t.datetime "updated_at",                    default: '2009-12-21 15:24:37'
    t.integer  "accounts",                      default: 0
  end

  create_table "strativa_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "strativa_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2009-12-21 15:24:37'
    t.datetime "last_accessed_timestamp",             default: '2009-12-21 15:24:37'
  end

  create_table "strativa_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "sunovion_taa_reports", force: :cascade do |t|
    t.integer  "user_id",                       null: false
    t.boolean  "is_corporate",  default: false
    t.boolean  "is_all_states", default: false
    t.boolean  "is_state",      default: false
    t.integer  "state_id"
    t.datetime "started_at",                    null: false
    t.datetime "completed_at"
    t.boolean  "is_complete",   default: false
  end

  create_table "takeda_custom_payor_actions", force: :cascade do |t|
    t.integer  "takeda_custom_payor_id"
    t.integer  "user_id"
    t.string   "health_plan_name",       limit: 255
    t.string   "action",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "takeda_custom_payor_notes", force: :cascade do |t|
    t.integer  "takeda_custom_payor_id"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
  end

  create_table "takeda_custom_payors", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "takeda_custom_payors_health_plans", id: false, force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "takeda_custom_payor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "takeda_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2010-01-05 16:54:42'
    t.datetime "updated_at",                              default: '2010-01-05 16:54:42'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "takeda_formularies", ["drug_class_id"], name: "takeda_formularies_drug_class_id_idx", using: :btree
  add_index "takeda_formularies", ["site_user_id"], name: "takeda_formularies_site_user_id_idx", using: :btree
  add_index "takeda_formularies", ["state_id"], name: "takeda_formularies_state_id_idx", using: :btree
  add_index "takeda_formularies", ["template"], name: "takeda_formularies_template_idx", using: :btree

  create_table "takeda_ims_geography_rollup_rx_counts", force: :cascade do |t|
    t.decimal "count_total",             null: false
    t.decimal "count_new",               null: false
    t.integer "imsfid",                  null: false
    t.string  "imsname",     limit: 255, null: false
    t.integer "imscode",     limit: 8,   null: false
    t.integer "drugfid",                 null: false
  end

  add_index "takeda_ims_geography_rollup_rx_counts", ["drugfid"], name: "takeda_ims_geography_rollup_rx_counts_drugfid_idx", using: :btree
  add_index "takeda_ims_geography_rollup_rx_counts", ["imsfid"], name: "takeda_ims_geography_rollup_rx_counts_imsfid_idx", using: :btree

  create_table "takeda_ims_mappings", id: false, force: :cascade do |t|
    t.integer "takeda_plan_key"
    t.integer "ims_code",        limit: 8
    t.integer "ims_id"
  end

  add_index "takeda_ims_mappings", ["ims_id"], name: "takeda_ims_mappings_ims_id", using: :btree

  create_table "takeda_ims_rx_counts", force: :cascade do |t|
    t.decimal "count_total", null: false
    t.decimal "count_new",   null: false
    t.integer "imsfid"
    t.integer "drugfid",     null: false
    t.integer "planfid"
    t.integer "msafid"
    t.integer "statefid"
    t.integer "countyfid"
  end

  add_index "takeda_ims_rx_counts", ["count_new"], name: "takeda_ims_rx_counts_count_new_idx", using: :btree
  add_index "takeda_ims_rx_counts", ["count_total"], name: "takeda_ims_rx_counts_count_total_idx", using: :btree
  add_index "takeda_ims_rx_counts", ["countyfid"], name: "takeda_ims_rx_counts_countyfid_idx", using: :btree
  add_index "takeda_ims_rx_counts", ["drugfid", "planfid", "countyfid"], name: "takeda_ims_rx_counts_drugfid_planfid_countyfid_idx", using: :btree
  add_index "takeda_ims_rx_counts", ["drugfid", "planfid", "msafid"], name: "takeda_ims_rx_counts_drugfid_planfid_msafid_idx", using: :btree
  add_index "takeda_ims_rx_counts", ["drugfid", "planfid", "statefid"], name: "takeda_ims_rx_counts_drugfid_planfid_statefid_idx", using: :btree
  add_index "takeda_ims_rx_counts", ["drugfid"], name: "takeda_ims_rx_counts_drugfid_idx", using: :btree
  add_index "takeda_ims_rx_counts", ["imsfid"], name: "takeda_ims_rx_counts_imsfid_idx", using: :btree
  add_index "takeda_ims_rx_counts", ["msafid"], name: "takeda_ims_rx_counts_msafid_idx", using: :btree
  add_index "takeda_ims_rx_counts", ["planfid"], name: "takeda_ims_rx_counts_planfid_idx", using: :btree
  add_index "takeda_ims_rx_counts", ["statefid"], name: "takeda_ims_rx_counts_statefid_idx", using: :btree

  create_table "takeda_odb_ims_rx", force: :cascade do |t|
    t.decimal "trx",                 precision: 12, scale: 3
    t.integer "ims_code",  limit: 8
    t.integer "drug_code"
    t.boolean "imported",                                     default: false, null: false
    t.boolean "in_use",                                       default: false, null: false
  end

  add_index "takeda_odb_ims_rx", ["ims_code"], name: "takeda_odb_ims_rx_ims_code", using: :btree

  create_table "takeda_odb_rx", id: false, force: :cascade do |t|
    t.integer "drug_code"
    t.decimal "trx",           precision: 12, scale: 6
    t.integer "healthplanfid"
  end

  create_table "takeda_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "takeda_plan_drug_options", ["created_by"], name: "takeda_plan_drug_options_created_by_idx", using: :btree
  add_index "takeda_plan_drug_options", ["updated_by"], name: "takeda_plan_drug_options_updated_by_idx", using: :btree

  create_table "takeda_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "takeda_plan_drug_settings", ["created_by"], name: "takeda_plan_drug_settings_created_by_idx", using: :btree
  add_index "takeda_plan_drug_settings", ["drug_id"], name: "takeda_plan_drug_settings_drug_id_idx", using: :btree
  add_index "takeda_plan_drug_settings", ["healthplan_id"], name: "takeda_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "takeda_plan_drug_settings", ["plan_drug_option_id"], name: "takeda_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "takeda_plan_drug_settings", ["state_id"], name: "takeda_plan_drug_settings_state_id_idx", using: :btree
  add_index "takeda_plan_drug_settings", ["updated_by"], name: "takeda_plan_drug_settings_updated_by_idx", using: :btree

  create_table "takeda_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "takeda_plan_type_groups", force: :cascade do |t|
    t.string "name",         limit: 10
    t.string "display_name"
  end

  create_table "takeda_product_keys_drugs", id: false, force: :cascade do |t|
    t.integer "product_key"
    t.string  "class_code"
    t.string  "submarket_code"
    t.string  "market_code"
    t.integer "drug_display_id"
    t.integer "drug_id"
  end

  add_index "takeda_product_keys_drugs", ["drug_id"], name: "takeda_product_keys_drugs_drug_id", using: :btree
  add_index "takeda_product_keys_drugs", ["market_code"], name: "takeda_product_keys_drugs_market_code", using: :btree
  add_index "takeda_product_keys_drugs", ["product_key"], name: "takeda_product_keys_drugs_product_key", using: :btree
  add_index "takeda_product_keys_drugs", ["submarket_code"], name: "takeda_product_keys_drugs_submarket_code", using: :btree

  create_table "takeda_provider_contact", force: :cascade do |t|
    t.integer  "active",                    default: 1,       null: false
    t.integer  "providerid_fk"
    t.string   "firstname",     limit: 50
    t.string   "lastname",      limit: 50
    t.string   "title",         limit: 100
    t.string   "phone1",        limit: 20
    t.string   "phone2",        limit: 20
    t.string   "phone_mobile",  limit: 20
    t.string   "fax",           limit: 20
    t.string   "email",         limit: 100
    t.string   "address1",      limit: 100
    t.string   "address2",      limit: 100
    t.string   "city",          limit: 50
    t.integer  "state_fk"
    t.string   "zip",           limit: 10
    t.integer  "creatorid_fk"
    t.datetime "create_stamp",              default: "now()"
    t.integer  "modbyid_fk"
    t.datetime "mod_stamp"
  end

  add_index "takeda_provider_contact", ["id"], name: "takeda_provider_contact_id_idx", using: :btree
  add_index "takeda_provider_contact", ["providerid_fk"], name: "takeda_provider_contact_providerid_idx", using: :btree
  add_index "takeda_provider_contact", ["state_fk"], name: "takeda_provider_contact_state_idx", using: :btree

  create_table "takeda_provider_contact_notes", force: :cascade do |t|
    t.integer  "contactid_fk"
    t.string   "note",         limit: 65536
    t.integer  "creatorid_fk"
    t.datetime "create_stamp",               default: "now()"
  end

  add_index "takeda_provider_contact_notes", ["contactid_fk"], name: "takeda_contact_notes_contactid_idx", using: :btree
  add_index "takeda_provider_contact_notes", ["create_stamp"], name: "takeda_contact_notes_create_stamp_idx", using: :btree
  add_index "takeda_provider_contact_notes", ["creatorid_fk"], name: "takeda_contact_notes_creatorid_idx", using: :btree

  create_table "takeda_roles", force: :cascade do |t|
    t.string   "role",                limit: 200
    t.string   "description",         limit: 200
    t.integer  "adminonly",                       default: 0
    t.integer  "requires_approval",               default: 0
    t.integer  "formulary_tables",                default: 0
    t.integer  "analytics",                       default: 0
    t.integer  "accounts",                        default: 0
    t.integer  "active",                          default: 1
    t.datetime "created_at",                      default: '2010-01-05 16:54:42'
    t.datetime "updated_at",                      default: '2010-01-05 16:54:42'
    t.integer  "alerts",                          default: 0
    t.boolean  "view_formulary_data",             default: false
  end

  create_table "takeda_rx_data", force: :cascade do |t|
    t.string  "plan_id",  limit: 10
    t.integer "drugfid"
    t.decimal "nrx",                 precision: 12, scale: 3
    t.decimal "trx",                 precision: 12, scale: 3
    t.integer "imscode",  limit: 8
    t.boolean "inuse",                                        default: false
    t.boolean "imported",                                     default: false
    t.integer "imsfid"
  end

  add_index "takeda_rx_data", ["drugfid"], name: "takeda_rx_data_drugfid", using: :btree
  add_index "takeda_rx_data", ["imported"], name: "takeda_rx_data_imported", using: :btree
  add_index "takeda_rx_data", ["imscode"], name: "takeda_rx_data_imscode", using: :btree
  add_index "takeda_rx_data", ["imsfid"], name: "takeda_rx_data_imsfid", using: :btree
  add_index "takeda_rx_data", ["inuse"], name: "takeda_rx_data_inuse", using: :btree
  add_index "takeda_rx_data", ["plan_id"], name: "takeda_rx_data_plan_id", using: :btree

  create_table "takeda_rx_facts", force: :cascade do |t|
    t.date    "month"
    t.string  "zipcode",        limit: 5
    t.integer "plan_key"
    t.integer "product_key"
    t.integer "rx_new_count"
    t.integer "rx_total_count"
    t.integer "drug_id"
    t.integer "zipcode_id"
    t.integer "county_id"
    t.integer "msa_id"
    t.integer "state_id"
    t.integer "ims_id"
  end

  add_index "takeda_rx_facts", ["ims_id"], name: "takeda_rx_facts_ims_id", using: :btree

  create_table "takeda_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "takeda_user_services_providers", id: false, force: :cascade do |t|
    t.integer "takeda_user_service_id"
    t.integer "provider_id"
  end

  create_table "takeda_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-01-05 16:54:42'
    t.datetime "last_accessed_timestamp",             default: '2010-01-05 16:54:42'
  end

  create_table "takeda_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "takeda_view_formulary_data_report", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "action",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "takeda_view_formulary_data_report_drugs", id: false, force: :cascade do |t|
    t.integer "report_id"
    t.integer "drug_id"
  end

  create_table "takeda_view_formulary_data_report_health_plans", id: false, force: :cascade do |t|
    t.integer "report_id"
    t.integer "health_plan_id"
  end

  create_table "takeda_wk_rx", force: :cascade do |t|
    t.string  "rmo_prod_nm",         limit: 30
    t.string  "plan_amc_nbr",        limit: 6
    t.string  "plan_typ_cd",         limit: 1
    t.float   "ptnt_co_pay_ins_amt"
    t.string  "clm_stus_cd",         limit: 1
    t.integer "plan_amc_id"
  end

  add_index "takeda_wk_rx", ["plan_amc_id"], name: "takeda_wk_rx_plan_amc_id", using: :btree

  create_table "takedarole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 30,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "takedauser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "takedauser", ["email"], name: "takedauser_email_key", unique: true, using: :btree

  create_table "takedauseralert", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                           null: false
    t.integer  "planfid"
    t.integer  "drugfid"
    t.integer  "drugclassfid"
    t.integer  "drugplanformfid"
    t.integer  "coveragestatusold"
    t.integer  "coveragestatusnew"
    t.boolean  "priorauthold"
    t.boolean  "priorauthnew"
    t.boolean  "quantlimitold"
    t.boolean  "quantlimitnew"
    t.boolean  "steptherold"
    t.boolean  "stepthernew"
    t.datetime "alerttimestamp",                    null: false
    t.datetime "createtimestamp",                   null: false
    t.boolean  "isemailsent",       default: false, null: false
    t.integer  "legacyfid"
    t.boolean  "restrotherold"
    t.boolean  "restrothernew"
    t.integer  "reasoncodeold"
    t.integer  "reasoncodenew"
    t.datetime "archived_at"
  end

  create_table "takedauserservice", primary_key: "entityid", force: :cascade do |t|
    t.integer "userfid",      null: false
    t.integer "drugclassfid"
  end

  create_table "takedausersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "temp_benefitstructure", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "healthplanfid"
    t.string   "benefitplanname",                 limit: 255
    t.string   "benefitplanurl",                  limit: 500
    t.string   "medicarecontractid",              limit: 50
    t.decimal  "deductible",                                  precision: 8, scale: 2
    t.string   "coveragegap",                     limit: 500
    t.string   "catastrophiccoverage",            limit: 500
    t.string   "comments",                        limit: 500
    t.datetime "createtimestamp"
    t.datetime "modifytimestamp"
    t.integer  "createdby"
    t.integer  "modifiedby"
    t.integer  "active"
    t.decimal  "premium"
    t.string   "source",                          limit: 3
    t.integer  "cms_plan_id"
    t.decimal  "specialty_copay_min",                         precision: 8, scale: 2
    t.decimal  "specialty_copay_max",                         precision: 8, scale: 2
    t.decimal  "specialty_coinsurance_min",                   precision: 8, scale: 2
    t.decimal  "specialty_coinsurance_max",                   precision: 8, scale: 2
    t.decimal  "medical_benefit_coinsurance_min",             precision: 8, scale: 2
    t.decimal  "medical_benefit_coinsurance_max",             precision: 8, scale: 2
    t.decimal  "medical_benefit_copay_min",                   precision: 8, scale: 2
    t.decimal  "medical_benefit_copay_max",                   precision: 8, scale: 2
  end

  create_table "temp_benefitstructurecopay", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "benefitstructurefid"
    t.integer  "pharmacytypefid"
    t.integer  "copaytypefid"
    t.integer  "dayssupply"
    t.datetime "createtimestamp"
    t.datetime "modifytimestamp"
    t.integer  "active"
    t.string   "source",              limit: 3
  end

  create_table "temp_benefitstructurecopayvalue", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "benefitstructurecopayfid"
    t.integer  "tierfid"
    t.decimal  "value",                              precision: 8, scale: 2
    t.decimal  "max",                                precision: 8, scale: 2
    t.decimal  "percentage",                         precision: 8, scale: 2
    t.datetime "createtimestamp"
    t.datetime "modifytimestamp"
    t.integer  "active"
    t.string   "source",                   limit: 3
    t.decimal  "percentage_max",                     precision: 8, scale: 2
  end

  create_table "temp_benefitstructurestate", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "benefitstructurefid"
    t.integer "statefid"
  end

  create_table "temp_health_plans_wk_plans", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "health_plan_id"
    t.integer "wk_plan_id"
  end

  create_table "temp_medicare_low_income_subsidy_lives", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "health_plan_id"
    t.integer "county_id"
    t.integer "state_id"
    t.integer "msa_id"
    t.decimal "lives"
    t.decimal "lives_original_value"
    t.boolean "lives_adjusted"
  end

  create_table "temp_medicare_low_income_subsidy_lives_import", id: false, force: :cascade do |t|
    t.string  "fipsst",                     limit: 2
    t.string  "fipscnty",                   limit: 3
    t.string  "contract_id",                limit: 5
    t.string  "enrolled",                   limit: 20
    t.integer "full_fips_id"
    t.integer "county_id"
    t.string  "health_plan_id_mapped_list", limit: 200
    t.integer "state_id"
    t.integer "msa_id"
    t.integer "id"
    t.boolean "is_imported"
  end

  create_table "temp_medicare_low_income_subsidy_lives_staging", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "health_plan_id"
    t.integer "county_id"
    t.integer "state_id"
    t.integer "msa_id"
    t.decimal "lives"
    t.decimal "lives_original_value"
  end

  create_table "temp_plan_mappings_no_matches", id: false, force: :cascade do |t|
    t.integer "id"
    t.string  "type",    limit: 255
    t.integer "plan_id"
    t.string  "reason",  limit: 255
  end

  create_table "temp_provider_contacts", id: false, force: :cascade do |t|
    t.integer "provider_id"
    t.string  "first_name",  limit: 255
    t.string  "last_name",   limit: 255
    t.string  "title",       limit: 255
    t.string  "phone_1",     limit: 255
    t.string  "email",       limit: 255
  end

  create_table "temp_wk_plans", id: false, force: :cascade do |t|
    t.integer "id"
    t.string  "name",                   limit: 255
    t.integer "amc_number"
    t.integer "pbm_amc_number"
    t.string  "type_code",              limit: 255
    t.string  "zipcode",                limit: 5
    t.string  "type_description"
    t.string  "type_group_code"
    t.string  "type_group_description"
  end

  create_table "teva_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2011-09-16 16:49:27'
    t.datetime "updated_at",                              default: '2011-09-16 16:49:27'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
  end

  add_index "teva_formularies", ["drug_class_id"], name: "teva_formularies_drug_class_id_idx", using: :btree
  add_index "teva_formularies", ["site_user_id"], name: "teva_formularies_site_user_id_idx", using: :btree
  add_index "teva_formularies", ["state_id"], name: "teva_formularies_state_id_idx", using: :btree
  add_index "teva_formularies", ["template"], name: "teva_formularies_template_idx", using: :btree

  create_table "teva_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "teva_plan_drug_options", ["created_by"], name: "teva_plan_drug_options_created_by_idx", using: :btree
  add_index "teva_plan_drug_options", ["updated_by"], name: "teva_plan_drug_options_updated_by_idx", using: :btree

  create_table "teva_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "teva_plan_drug_settings", ["created_by"], name: "teva_plan_drug_settings_created_by_idx", using: :btree
  add_index "teva_plan_drug_settings", ["drug_id"], name: "teva_plan_drug_settings_drug_id_idx", using: :btree
  add_index "teva_plan_drug_settings", ["healthplan_id"], name: "teva_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "teva_plan_drug_settings", ["plan_drug_option_id"], name: "teva_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "teva_plan_drug_settings", ["state_id"], name: "teva_plan_drug_settings_state_id_idx", using: :btree
  add_index "teva_plan_drug_settings", ["updated_by"], name: "teva_plan_drug_settings_updated_by_idx", using: :btree

  create_table "teva_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teva_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teva_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "teva_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "teva_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2011-09-16 16:49:27'
    t.datetime "last_accessed_timestamp",             default: '2011-09-16 16:49:27'
  end

  create_table "tevaformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                              null: false
    t.integer  "statefid",                 limit: 8
    t.integer  "drugclassfid",             limit: 8,                   null: false
    t.string   "planlist",                                             null: false
    t.string   "druglist",                                             null: false
    t.string   "tableversion",             limit: 100,                 null: false
    t.integer  "versionnumber",            limit: 8,   default: 0,     null: false
    t.integer  "ispublished",              limit: 8,   default: 0,     null: false
    t.integer  "isexported",               limit: 8,   default: 0,     null: false
    t.integer  "isactive",                 limit: 8,   default: 1,     null: false
    t.datetime "createtimestamp",                                      null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "modifytimestamp",                                      null: false
    t.integer  "mostrecent",               limit: 8,   default: 0,     null: false
    t.string   "planorderedlist",          limit: 500
    t.string   "planboldedlist",           limit: 500
    t.string   "description",              limit: 100
    t.string   "doctorname",               limit: 100
    t.integer  "tabletype",                limit: 8,   default: 1,     null: false
    t.string   "template",                 limit: 50
    t.string   "repname",                  limit: 100
    t.string   "plan_type_category_order", limit: 50
    t.integer  "header_option"
    t.string   "mark_new_list",            limit: 500
    t.string   "geo_area_name",            limit: 255
    t.boolean  "display_copay",                        default: false
  end

  add_index "tevaformulary", ["drugclassfid"], name: "tevaformulary_drugclassid_idx", using: :btree
  add_index "tevaformulary", ["statefid"], name: "tevaformulary_stateid_idx", using: :btree
  add_index "tevaformulary", ["userfid"], name: "tevaformulary_userid_idx", using: :btree

  create_table "tevaformulary_201205", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.integer  "userfid"
    t.integer  "statefid",                 limit: 8
    t.integer  "drugclassfid",             limit: 8
    t.string   "planlist"
    t.string   "druglist"
    t.string   "tableversion",             limit: 100
    t.integer  "versionnumber",            limit: 8
    t.integer  "ispublished",              limit: 8
    t.integer  "isexported",               limit: 8
    t.integer  "isactive",                 limit: 8
    t.datetime "createtimestamp"
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "modifytimestamp"
    t.integer  "mostrecent",               limit: 8
    t.string   "planorderedlist",          limit: 500
    t.string   "planboldedlist",           limit: 500
    t.string   "description",              limit: 100
    t.string   "doctorname",               limit: 100
    t.integer  "tabletype",                limit: 8
    t.string   "template",                 limit: 50
    t.string   "repname",                  limit: 100
    t.string   "plan_type_category_order", limit: 50
    t.integer  "header_option"
    t.string   "mark_new_list",            limit: 500
    t.string   "geo_area_name",            limit: 255
    t.boolean  "display_copay"
  end

  create_table "tevarole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 50,                  null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",        limit: 8,   default: 0,     null: false
    t.integer  "requiresapproval", limit: 8,   default: 0,     null: false
    t.integer  "createtable",      limit: 8,   default: 0,     null: false
    t.datetime "createtimestamp",                              null: false
    t.datetime "modifytimestamp",                              null: false
    t.integer  "restrictions",                 default: 0
    t.boolean  "is_super_user",                default: false
  end

  create_table "tevarole_201205", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.string   "role",             limit: 50
    t.string   "description",      limit: 500
    t.integer  "adminonly",        limit: 8
    t.integer  "requiresapproval", limit: 8
    t.integer  "createtable",      limit: 8
    t.datetime "createtimestamp"
    t.datetime "modifytimestamp"
    t.integer  "restrictions"
    t.boolean  "is_super_user"
  end

  create_table "tevauser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid",            limit: 8,               null: false
    t.integer  "isactive",           limit: 8,   default: 0, null: false
    t.integer  "isalerts",           limit: 8,   default: 0, null: false
    t.integer  "isapproved",         limit: 8,   default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "tevauser", ["email"], name: "tevauser_email_key", unique: true, using: :btree

  create_table "tevauser_201205", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.string   "email",              limit: 200
    t.string   "password",           limit: 200
    t.string   "firstname",          limit: 200
    t.string   "lastname",           limit: 200
    t.integer  "rolefid",            limit: 8
    t.integer  "isactive",           limit: 8
    t.integer  "isalerts",           limit: 8
    t.integer  "isapproved",         limit: 8
    t.string   "activationkey",      limit: 50
    t.datetime "createtimestamp"
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp"
  end

  create_table "tevausersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",               limit: 8,               null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",            limit: 8,   default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "tevausersession_201205", id: false, force: :cascade do |t|
    t.integer  "entityid"
    t.integer  "userfid",               limit: 8
    t.string   "sessionid",             limit: 200
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp"
    t.integer  "logincount",            limit: 8
    t.datetime "lastaccessedtimestamp"
  end

  create_table "therapeuticarea", force: :cascade do |t|
    t.boolean "isactive",                    null: false
    t.string  "name",            limit: 255, null: false
    t.string  "webname",         limit: 255, null: false
    t.string  "rewritename",     limit: 255, null: false
    t.string  "bookname",        limit: 255, null: false
    t.integer "bookletcolorfid",             null: false
    t.integer "legacyfid"
  end

  add_index "therapeuticarea", ["bookname"], name: "therapeuticarea_bookname_key", unique: true, using: :btree
  add_index "therapeuticarea", ["name"], name: "therapeuticarea_name_key", unique: true, using: :btree
  add_index "therapeuticarea", ["rewritename"], name: "therapeuticarea_rewritename_key", unique: true, using: :btree
  add_index "therapeuticarea", ["webname"], name: "therapeuticarea_webname_key", unique: true, using: :btree

  create_table "tier", force: :cascade do |t|
    t.boolean "isactive",                    null: false
    t.string  "name",            limit: 255, null: false
    t.string  "codename",        limit: 20,  null: false
    t.text    "explanationtext"
    t.integer "orderindex",                  null: false
    t.integer "legacyvalue"
  end

  add_index "tier", ["codename"], name: "tier_codename_key", unique: true, using: :btree
  add_index "tier", ["name"], name: "tier_name_key", unique: true, using: :btree
  add_index "tier", ["orderindex"], name: "tier_orderindex_key", unique: true, using: :btree

  create_table "tierstructure", force: :cascade do |t|
    t.string  "name",    limit: 200, null: false
    t.integer "orderid",             null: false
  end

  create_table "tmp_afinitor_pa", id: false, force: :cascade do |t|
    t.integer "provider_id"
    t.string  "provider_name",     limit: 255
    t.string  "Provider_PlanType", limit: 255
    t.integer "Drug_Class_id"
    t.integer "Drug_id"
    t.integer "Plan_type_Id"
    t.string  "PLAN TYPE",         limit: 255
    t.string  "PA FORM LINK",      limit: 1000
  end

  create_table "tmp_cm", id: false, force: :cascade do |t|
    t.integer "healthplanfid"
    t.integer "commentfid",    default: 9853
    t.integer "commenttype",   default: 4
  end

  create_table "tmp_feqcriteriaentry", id: false, force: :cascade do |t|
    t.integer  "id"
    t.integer  "feqfid"
    t.integer  "criteriaentryfid"
    t.integer  "drugclassfid"
    t.text     "notes"
    t.datetime "lastupdate",                         precision: 6
    t.integer  "lastupdateffuserid"
    t.integer  "healthplanfid"
    t.string   "restrictionflag",          limit: 5
    t.integer  "reportfid"
    t.text     "restriction_details"
    t.integer  "providerfid"
    t.text     "internal_comments_unused"
    t.boolean  "feqfid_is_updated"
  end

  create_table "tmp_ims_mapping", id: false, force: :cascade do |t|
    t.string  "payer_name", limit: 255
    t.integer "code",       limit: 8
    t.string  "name",       limit: 255
    t.string  "state",      limit: 255
    t.integer "plan_Id"
    t.string  "FF_Plan",    limit: 255
    t.integer "ff_ims_id"
  end

  create_table "tmp_imshealthplan_20141210", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "healthplanfid"
    t.integer "imsfid"
  end

  create_table "ucbdistrict", primary_key: "entityid", force: :cascade do |t|
    t.string  "code",     limit: 50,              null: false
    t.string  "name",     limit: 200,             null: false
    t.integer "isactive",             default: 1, null: false
  end

  create_table "ucbdistrictstate", primary_key: "entityid", force: :cascade do |t|
    t.integer "districtfid", null: false
    t.integer "statefid",    null: false
  end

  create_table "ucbdrugplanform", primary_key: "entityid", force: :cascade do |t|
    t.integer "formularyfid",                   null: false
    t.integer "planid",                         null: false
    t.integer "drugid",                         null: false
    t.integer "coveragestatus",                 null: false
    t.boolean "priorauth",                      null: false
    t.boolean "quantlimit",                     null: false
    t.boolean "stepther",                       null: false
    t.integer "resetflag",      default: 0,     null: false
    t.integer "paforall",       default: 0,     null: false
    t.boolean "restrother",     default: false, null: false
    t.integer "reasoncodefid",  default: 0,     null: false
  end

  create_table "ucbformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                   null: false
    t.integer  "districtfid",                               null: false
    t.integer  "statefid",                                  null: false
    t.integer  "drugclassfid",                              null: false
    t.string   "planlist",         limit: 1000,             null: false
    t.string   "druglist",         limit: 100,              null: false
    t.string   "tableversion",     limit: 100,              null: false
    t.integer  "versionnumber",                 default: 0, null: false
    t.integer  "ispublished",                   default: 0, null: false
    t.integer  "isexported",                    default: 0, null: false
    t.integer  "isactive",                      default: 1, null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "createtimestamp",                           null: false
    t.datetime "modifytimestamp",                           null: false
    t.integer  "mostrecent",                    default: 0, null: false
    t.string   "template",         limit: 50
  end

  create_table "ucbrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "ucbuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "ucbuser", ["email"], name: "ucbuser_email_key", unique: true, using: :btree

  create_table "ucbusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "url_formularies", force: :cascade do |t|
    t.integer  "active",                                  default: 1
    t.integer  "published",                               default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                              default: '2010-04-02 11:05:22'
    t.datetime "updated_at",                              default: '2010-04-02 11:05:22'
    t.datetime "published_at"
    t.string   "title",                       limit: 100
    t.string   "template",                    limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",             limit: 255
    t.string   "physician_name",              limit: 255
    t.string   "rep_name",                    limit: 255
    t.string   "spotlight_drug_list",         limit: 255
    t.string   "competitor_drug_list",        limit: 255
    t.string   "plan_type_order_list",        limit: 255
    t.string   "commercial_plans_order_list", limit: 255
    t.string   "medicare_plans_order_list",   limit: 255
    t.string   "medicaid_plans_order_list",   limit: 255
    t.string   "highlight_plan_list",         limit: 255
    t.string   "bold_plan_list",              limit: 255
    t.integer  "msa_id"
  end

  add_index "url_formularies", ["drug_class_id"], name: "url_formularies_drug_class_id_idx", using: :btree
  add_index "url_formularies", ["site_user_id"], name: "url_formularies_site_user_id_idx", using: :btree
  add_index "url_formularies", ["state_id"], name: "url_formularies_state_id_idx", using: :btree
  add_index "url_formularies", ["template"], name: "url_formularies_template_idx", using: :btree

  create_table "url_pdf_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "publisher_formulary_name", limit: 255
    t.integer  "publisher_formulary_id"
    t.string   "environment",              limit: 255
    t.string   "file_name",                limit: 255
    t.string   "pdf_unique_id",            limit: 255
  end

  create_table "url_plan_drug_options", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",              default: "now()"
    t.integer  "updated_by"
    t.integer  "active",                  default: 1
    t.string   "description", limit: 255
  end

  add_index "url_plan_drug_options", ["created_by"], name: "url_plan_drug_options_created_by_idx", using: :btree
  add_index "url_plan_drug_options", ["updated_by"], name: "url_plan_drug_options_updated_by_idx", using: :btree

  create_table "url_plan_drug_settings", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "drug_id"
    t.integer  "state_id"
    t.integer  "plan_drug_option_id"
    t.datetime "enable_at",           default: "now()", null: false
    t.datetime "expire_at",           default: "now()", null: false
    t.integer  "active",              default: 1
    t.datetime "created_at",          default: "now()"
    t.integer  "created_by"
    t.datetime "updated_at",          default: "now()"
    t.integer  "updated_by"
  end

  add_index "url_plan_drug_settings", ["created_by"], name: "url_plan_drug_settings_created_by_idx", using: :btree
  add_index "url_plan_drug_settings", ["drug_id"], name: "url_plan_drug_settings_drug_id_idx", using: :btree
  add_index "url_plan_drug_settings", ["healthplan_id"], name: "url_plan_drug_settings_healthplan_id_idx", using: :btree
  add_index "url_plan_drug_settings", ["plan_drug_option_id"], name: "url_plan_drug_settings_plan_drug_option_id_idx", using: :btree
  add_index "url_plan_drug_settings", ["state_id"], name: "url_plan_drug_settings_state_id_idx", using: :btree
  add_index "url_plan_drug_settings", ["updated_by"], name: "url_plan_drug_settings_updated_by_idx", using: :btree

  create_table "url_plan_exclusions", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "state_id"
    t.boolean  "active",         default: true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "url_plan_names", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "healthplan_id",             null: false
    t.string   "name",          limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "url_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "url_publisher_activity_report_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "url_publisher_activity_report_states", force: :cascade do |t|
    t.integer  "state_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "url_publisher_activity_report_templates", force: :cascade do |t|
    t.integer  "template_id"
    t.integer  "publisher_activity_report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "template_type",                limit: 255
  end

  create_table "url_publisher_activity_reports", force: :cascade do |t|
    t.boolean  "use_preset_date"
    t.string   "preset_date",     limit: 255
    t.date     "end_date"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "url_publisher_formularies", force: :cascade do |t|
    t.integer  "publisher_template_id"
    t.string   "name",                        limit: 255
    t.integer  "created_by_id"
    t.boolean  "is_active",                               default: true
    t.boolean  "is_published",                            default: false
    t.string   "current_step",                limit: 255
    t.integer  "state_id"
    t.integer  "msa_id"
    t.string   "competitor_drug_ids",         limit: 255, default: ""
    t.string   "health_plan_types",           limit: 255, default: ""
    t.string   "commercial_health_plan_ids",  limit: 255, default: ""
    t.string   "medicare_health_plan_ids",    limit: 255, default: ""
    t.string   "medicaid_health_plan_ids",    limit: 255, default: ""
    t.string   "highlighted_health_plan_ids", limit: 255, default: ""
    t.string   "bolded_health_plan_ids",      limit: 255, default: ""
    t.string   "geographic_customization",    limit: 255, default: ""
    t.string   "physician_customization",     limit: 255, default: ""
    t.integer  "header_type",                             default: 0
    t.boolean  "display_copay",                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rep_name",                    limit: 255, default: ""
    t.integer  "county_id"
  end

  create_table "url_publisher_templates", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.string   "klass_name",                limit: 255
    t.string   "spotlight_drug_ids",        limit: 255, default: ""
    t.string   "competitor_drug_ids",       limit: 255, default: ""
    t.integer  "health_plan_count_min"
    t.integer  "health_plan_count_max"
    t.integer  "competitor_drug_count_min"
    t.integer  "competitor_drug_count_max"
    t.string   "allowed_role_ids",          limit: 255, default: ""
    t.boolean  "is_active",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activation_change_comment", limit: 255
  end

  create_table "url_roles", force: :cascade do |t|
    t.string   "role",                limit: 200
    t.string   "description",         limit: 200
    t.integer  "adminonly",                       default: 0
    t.integer  "requires_approval",               default: 0
    t.integer  "formulary_tables",                default: 0
    t.integer  "analytics",                       default: 0
    t.integer  "active",                          default: 1
    t.boolean  "is_super_user",                   default: false
    t.datetime "created_at",                      default: '2010-04-02 11:05:22'
    t.datetime "updated_at",                      default: '2010-04-02 11:05:22'
    t.boolean  "publisher_reporting",             default: false
  end

  create_table "url_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at",                      default: "now()"
    t.datetime "updated_at",                      default: "now()"
  end

  create_table "url_user_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id",              limit: 200
    t.string   "ip_address",              limit: 200
    t.integer  "login_count",                         default: 0
    t.datetime "login_timestamp",                     default: '2010-04-02 11:05:22'
    t.datetime "last_accessed_timestamp",             default: '2010-04-02 11:05:22'
  end

  create_table "url_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.string   "changes",    limit: 255
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "vyvanse_health_plan_dma_lives", id: false, force: :cascade do |t|
    t.integer "provider_id"
    t.integer "health_plan_id"
    t.integer "health_plan_type_id"
    t.integer "dma_id"
    t.decimal "lives"
    t.integer "tier_id"
  end

  add_index "vyvanse_health_plan_dma_lives", ["provider_id", "health_plan_id", "health_plan_type_id", "dma_id"], name: "vyvanse_health_plan_dma_lives_search_ind", using: :btree

  create_table "vyvanse_health_plan_state_lives", id: false, force: :cascade do |t|
    t.integer "provider_id"
    t.integer "health_plan_id"
    t.integer "health_plan_type_id"
    t.integer "state_id"
    t.decimal "lives"
    t.integer "tier_id"
  end

  add_index "vyvanse_health_plan_state_lives", ["provider_id", "health_plan_id", "health_plan_type_id", "state_id"], name: "vyvanse_health_plan_state_lives_search_ind", using: :btree

  create_table "warnerdrugplanform", primary_key: "entityid", force: :cascade do |t|
    t.integer "formularyfid",                           null: false
    t.integer "planid",                                 null: false
    t.integer "drugid",                                 null: false
    t.integer "coveragestatus",                         null: false
    t.boolean "priorauth",                              null: false
    t.boolean "quantlimit",                             null: false
    t.boolean "stepther",                               null: false
    t.boolean "restrother",                             null: false
    t.integer "reasoncodefid",              default: 0, null: false
    t.integer "resetflag",                  default: 0, null: false
    t.string  "warnerplanname", limit: 255
    t.integer "warnertierfid",              default: 8, null: false
  end

  create_table "warnerformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                    null: false
    t.integer  "statefid",                                   null: false
    t.integer  "drugclassfid",                               null: false
    t.string   "planlist",         limit: 1000,              null: false
    t.string   "druglist",         limit: 100,               null: false
    t.integer  "tabletype",                                  null: false
    t.string   "tableversion",     limit: 100,               null: false
    t.integer  "versionnumber",                 default: 0,  null: false
    t.integer  "ispublished",                   default: 0,  null: false
    t.integer  "isexported",                    default: 0,  null: false
    t.integer  "isactive",                      default: 1,  null: false
    t.integer  "mostrecent",                    default: 0,  null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "createtimestamp",                            null: false
    t.datetime "modifytimestamp",                            null: false
    t.string   "template",         limit: 20,   default: ""
  end

  create_table "warnerrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.integer  "manageuser",                   default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "warnertier", force: :cascade do |t|
    t.boolean "isactive",                    null: false
    t.string  "name",            limit: 255, null: false
    t.string  "codename",        limit: 20,  null: false
    t.text    "explanationtext"
    t.integer "orderindex",                  null: false
    t.string  "equivalents",     limit: 100
  end

  add_index "warnertier", ["codename"], name: "warnertier_codename_key", unique: true, using: :btree
  add_index "warnertier", ["name"], name: "warnertier_name_key", unique: true, using: :btree
  add_index "warnertier", ["orderindex"], name: "warnertier_orderindex_key", unique: true, using: :btree

  create_table "warneruser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",              limit: 200,             null: false
    t.string   "password",           limit: 200,             null: false
    t.string   "firstname",          limit: 200,             null: false
    t.string   "lastname",           limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                       default: 0, null: false
    t.integer  "isalerts",                       default: 0, null: false
    t.integer  "isapproved",                     default: 0, null: false
    t.string   "activationkey",      limit: 50,              null: false
    t.datetime "createtimestamp",                            null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                            null: false
  end

  add_index "warneruser", ["email"], name: "warneruser_email_key", unique: true, using: :btree

  create_table "warnerusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
  end

  create_table "wc_formularies", force: :cascade do |t|
    t.integer  "active",                                           default: 1
    t.integer  "published",                                        default: 0
    t.integer  "site_user_id"
    t.datetime "created_at",                                       default: '2010-02-23 10:24:40'
    t.datetime "updated_at",                                       default: '2010-02-23 10:24:40'
    t.datetime "published_at"
    t.string   "title",                                limit: 100
    t.string   "version",                              limit: 100
    t.integer  "version_number",                                   default: 0
    t.string   "template",                             limit: 50
    t.integer  "drug_class_id"
    t.integer  "state_id"
    t.string   "geographic_area",                      limit: 255
    t.string   "spotlight_drug_list",                  limit: 255
    t.string   "additional_site_drug_list",            limit: 255
    t.string   "competitor_drug_list",                 limit: 255
    t.string   "plan_type_order_list",                 limit: 255
    t.string   "preferred_provider_list",              limit: 255
    t.string   "commercial_provider_order_list",       limit: 255
    t.string   "medicare_provider_order_list",         limit: 255
    t.string   "medicaid_provider_order_list",         limit: 255
    t.string   "new_provider_list",                    limit: 255
    t.string   "bold_provider_list",                   limit: 255
    t.boolean  "display_restrictions",                             default: false
    t.integer  "msa_id"
    t.string   "commercial_provider_list",             limit: 255
    t.string   "medicare_provider_list",               limit: 255
    t.string   "medicaid_provider_list",               limit: 255
    t.string   "companion_drug_list",                  limit: 255
    t.string   "municipal_provider_order_list",        limit: 255
    t.string   "municipal_provider_list",              limit: 255
    t.string   "commercial_provider_highlighted_list", limit: 255
    t.string   "medicare_provider_highlighted_list",   limit: 255
    t.string   "medicaid_provider_highlighted_list",   limit: 255
    t.string   "municipal_provider_highlighted_list",  limit: 255
  end

  add_index "wc_formularies", ["drug_class_id"], name: "wc_formularies_drug_class_id_idx", using: :btree
  add_index "wc_formularies", ["site_user_id"], name: "wc_formularies_site_user_id_idx", using: :btree
  add_index "wc_formularies", ["state_id"], name: "wc_formularies_state_id_idx", using: :btree
  add_index "wc_formularies", ["template"], name: "wc_formularies_template_idx", using: :btree

  create_table "wc_plan_tier_labels", force: :cascade do |t|
    t.integer  "healthplan_id"
    t.integer  "tier_id"
    t.integer  "tier_label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "wc_preferred_provider_inclusions", force: :cascade do |t|
    t.boolean  "active",             default: true
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "wc_provider_custom", force: :cascade do |t|
    t.integer  "provider_id"
    t.string   "name",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "wc_provider_exclusions", force: :cascade do |t|
    t.boolean  "active",             default: true
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
  end

  create_table "wc_provider_plans", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "healthplan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by_user_id"
    t.integer  "custom_provider_id"
  end

  create_table "wc_roles", force: :cascade do |t|
    t.string   "role",             limit: 200
    t.string   "description",      limit: 200
    t.integer  "adminonly",                    default: 0
    t.integer  "requiresapproval",             default: 0
    t.integer  "formulary_tables",             default: 0
    t.integer  "analytics",                    default: 0
    t.integer  "active",                       default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accounts",                     default: 0
  end

  create_table "wc_tier_labels", force: :cascade do |t|
    t.integer  "tier_id"
    t.string   "label",               limit: 255
    t.boolean  "display_qual",                    default: true
    t.string   "medicaid_preference", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wc_users", force: :cascade do |t|
    t.string   "login",         limit: 255
    t.string   "email",         limit: 255
    t.string   "password",      limit: 40
    t.datetime "created_at"
    t.datetime "activated_at"
    t.datetime "approved_at"
    t.datetime "updated_at"
    t.string   "first_name",    limit: 200
    t.string   "last_name",     limit: 200
    t.integer  "site_role_id"
    t.integer  "active",                    default: 0
    t.integer  "approved",                  default: 0
    t.integer  "alerts",                    default: 0
    t.string   "activationkey", limit: 50
  end

  create_table "wcusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid"
    t.string   "sessionid",             limit: 255
    t.string   "ipaddress",             limit: 255
    t.datetime "logintimestamp"
    t.integer  "logincount"
    t.datetime "lastaccessedtimestamp"
  end

  create_table "wk_plan_health_plan_allocations", id: false, force: :cascade do |t|
    t.integer "health_plan_id"
    t.integer "wk_plan_id"
    t.integer "health_plan_count",   limit: 8
    t.decimal "health_plan_lives"
    t.decimal "wk_plan_lives"
    t.text    "allocation_paradigm"
    t.decimal "allocation"
  end

  create_table "wk_plans", force: :cascade do |t|
    t.string  "name",                   limit: 255
    t.integer "amc_number",                         null: false
    t.integer "pbm_amc_number"
    t.string  "type_code",              limit: 255
    t.string  "zipcode",                limit: 5
    t.string  "type_description"
    t.string  "type_group_code"
    t.string  "type_group_description"
    t.string  "comments",               limit: 255
  end

  create_table "wyeth_plan_tier_label", id: false, force: :cascade do |t|
    t.integer  "healthplan_id_fk",                   null: false
    t.integer  "tier_id_fk",                         null: false
    t.integer  "tier_label_id_fk",                   null: false
    t.datetime "create_timestamp", default: "now()"
    t.datetime "modify_timestamp", default: "now()"
  end

  add_index "wyeth_plan_tier_label", ["healthplan_id_fk"], name: "wyeth_tier_label_tier_healthplan_id", using: :btree
  add_index "wyeth_plan_tier_label", ["tier_id_fk"], name: "wyeth_tier_label_tier_tier_id", using: :btree
  add_index "wyeth_plan_tier_label", ["tier_label_id_fk"], name: "wyeth_tier_label_tier_tier_label_id", using: :btree

  create_table "wyeth_tier_label", force: :cascade do |t|
    t.integer  "tier_id_fk",                                         null: false
    t.string   "label",                limit: 255
    t.boolean  "display_qual",                     default: true
    t.string   "qualifier_limit_list", limit: 255
    t.datetime "create_timestamp",                 default: "now()"
    t.datetime "modify_timestamp",                 default: "now()"
    t.integer  "active",                           default: 1,       null: false
  end

  add_index "wyeth_tier_label", ["tier_id_fk"], name: "wyeth_tier_label_tier_id", using: :btree

  create_table "wyethdrugplanform", primary_key: "entityid", force: :cascade do |t|
    t.integer "formularyfid",               null: false
    t.integer "planid",                     null: false
    t.integer "drugid",                     null: false
    t.integer "coveragestatus",             null: false
    t.boolean "priorauth",                  null: false
    t.boolean "quantlimit",                 null: false
    t.boolean "stepther",                   null: false
    t.boolean "restrother",                 null: false
    t.integer "resaoncodefid",  default: 0, null: false
    t.integer "resetflag",      default: 0, null: false
    t.integer "paforall",       default: 0, null: false
  end

  create_table "wyethformulary", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                          null: false
    t.integer  "statefid",                                         null: false
    t.integer  "msafid",                               default: 0
    t.integer  "drugclassfid",                                     null: false
    t.string   "planlist",                                         null: false
    t.string   "druglist",                                         null: false
    t.string   "tableversion",             limit: 100,             null: false
    t.integer  "versionnumber",                        default: 0, null: false
    t.integer  "ispublished",                          default: 0, null: false
    t.integer  "isexported",                           default: 0, null: false
    t.integer  "isactive",                             default: 1, null: false
    t.datetime "createtimestamp",                                  null: false
    t.datetime "publishtimestamp"
    t.datetime "exporttimestamp"
    t.datetime "modifytimestamp",                                  null: false
    t.integer  "mostrecent",                           default: 0, null: false
    t.string   "planorderedlist"
    t.string   "description",              limit: 100
    t.string   "doctorname",               limit: 100
    t.integer  "tabletype",                            default: 1, null: false
    t.string   "template",                 limit: 50
    t.string   "repname",                  limit: 100
    t.integer  "segmenttable",                         default: 0, null: false
    t.string   "localename",               limit: 100
    t.integer  "analyticsheader",                      default: 0, null: false
    t.integer  "displaycompaniontable",                default: 0, null: false
    t.string   "plantype",                 limit: 50
    t.string   "plan_type_category_order", limit: 50
    t.integer  "olduserfid"
    t.string   "old_template_name",        limit: 50
    t.integer  "old_tabletype"
  end

  add_index "wyethformulary", ["drugclassfid"], name: "wyethformulary_drugclassid_idx", using: :btree
  add_index "wyethformulary", ["msafid"], name: "wyethformulary_msaid_idx", using: :btree
  add_index "wyethformulary", ["statefid"], name: "wyethformulary_stateid_idx", using: :btree
  add_index "wyethformulary", ["userfid"], name: "wyethformulary_userid_idx", using: :btree

  create_table "wyethmsa", force: :cascade do |t|
    t.string   "name",        limit: 100,                   null: false
    t.string   "description", limit: 100
    t.datetime "modified",                default: "now()", null: false
    t.integer  "active",                  default: 1,       null: false
  end

  create_table "wyethmsahealthplan", force: :cascade do |t|
    t.integer  "msafid",                          null: false
    t.integer  "healthplanfid",                   null: false
    t.integer  "statefid",                        null: false
    t.datetime "modified",      default: "now()", null: false
    t.integer  "active",        default: 1,       null: false
  end

  create_table "wyethmsastate", force: :cascade do |t|
    t.integer  "msafid",                     null: false
    t.integer  "statefid",                   null: false
    t.datetime "modified", default: "now()", null: false
    t.integer  "active",   default: 1,       null: false
  end

  create_table "wyethrole", primary_key: "entityid", force: :cascade do |t|
    t.string   "role",             limit: 20,              null: false
    t.string   "description",      limit: 500
    t.integer  "adminonly",                    default: 0, null: false
    t.integer  "requiresapproval",             default: 0, null: false
    t.integer  "createtable",                  default: 0, null: false
    t.datetime "createtimestamp",                          null: false
    t.datetime "modifytimestamp",                          null: false
  end

  create_table "wyethterritory", force: :cascade do |t|
    t.string   "territoryid",               limit: 20,               null: false
    t.string   "businessunit",              limit: 100
    t.string   "rolename",                  limit: 20
    t.integer  "rolefid"
    t.integer  "isactive",                              default: 1,  null: false
    t.datetime "createtimestamp"
    t.datetime "modifytimestamp"
    t.string   "arealisting",               limit: 100
    t.string   "firstname",                 limit: 50
    t.string   "lastname",                  limit: 50
    t.integer  "isanalytics",                           default: -1, null: false
    t.datetime "isanalytics_modified_date"
    t.integer  "isanalytics_modified_by"
  end

  add_index "wyethterritory", ["territoryid"], name: "wyethterritory_territoryid_idx", using: :btree

  create_table "wyethuser", primary_key: "entityid", force: :cascade do |t|
    t.string   "email",                     limit: 200,             null: false
    t.string   "password",                  limit: 200,             null: false
    t.string   "firstname",                 limit: 200,             null: false
    t.string   "lastname",                  limit: 200,             null: false
    t.integer  "rolefid"
    t.integer  "isactive",                              default: 0, null: false
    t.integer  "isalerts",                              default: 0, null: false
    t.integer  "isapproved",                            default: 0, null: false
    t.string   "activationkey",             limit: 50,              null: false
    t.datetime "createtimestamp",                                   null: false
    t.datetime "activatedtimestamp"
    t.datetime "approvedtimestamp"
    t.datetime "modifytimestamp",                                   null: false
    t.integer  "isanalytics",                           default: 0, null: false
    t.datetime "isanalytics_modified_date"
    t.integer  "isanalytics_modified_by"
  end

  add_index "wyethuser", ["email"], name: "wyethuser_email_key", unique: true, using: :btree

  create_table "wyethusersession", primary_key: "entityid", force: :cascade do |t|
    t.integer  "userfid",                                       null: false
    t.string   "sessionid",             limit: 200,             null: false
    t.string   "ipaddress",             limit: 200
    t.datetime "logintimestamp",                                null: false
    t.integer  "logincount",                        default: 0, null: false
    t.datetime "lastaccessedtimestamp",                         null: false
    t.integer  "olduserfid"
  end

  add_index "wyethusersession", ["userfid"], name: "wyethusersession_userfid_idx", using: :btree

  create_table "zip_code_group_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zip_code_groups", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.integer  "brand_grouping_id"
    t.integer  "zip_code_id"
    t.integer  "zip_code_group_type_id"
    t.integer  "state_id"
    t.string   "city",                   limit: 255
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "territory_id",           limit: 255
    t.boolean  "active",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zipcode", force: :cascade do |t|
    t.string  "zipcode",     limit: 5,                null: false
    t.boolean "usps_active",           default: true, null: false
    t.integer "population",            default: 0
  end

  add_index "zipcode", ["zipcode"], name: "zipcode_zipcode", unique: true, using: :btree

  add_foreign_key "address", "addresstype", column: "addresstypefid", name: "address_addresstypefid_fkey"
  add_foreign_key "alcon_plan_drug_options", "alcon_users", column: "created_by", name: "alcon_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "alcon_plan_drug_options", "alcon_users", column: "updated_by", name: "alcon_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "alcon_plan_drug_settings", "alcon_plan_drug_options", column: "plan_drug_option_id", name: "alcon_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_plan_drug_settings", "alcon_users", column: "created_by", name: "alcon_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "alcon_plan_drug_settings", "alcon_users", column: "updated_by", name: "alcon_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "alcon_plan_drug_settings", "drug", name: "alcon_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_plan_drug_settings", "healthplan", name: "alcon_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_plan_drug_settings", "state", name: "alcon_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_plan_settings", "healthplan", name: "alcon_plan_settings_healthplan_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "alcon_plan_settings", "state", name: "alcon_plan_settings_state_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "alcon_plan_tier_label", "alcon_tier_label", column: "tier_label_id_fk", name: "alcon_plan_tier_label_tier_label_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_plan_tier_label", "healthplan", column: "healthplan_id_fk", name: "alcon_plan_tier_label_healthplan_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_plan_tier_label", "tier", column: "tier_id_fk", name: "alcon_plan_tier_label_tier_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_plan_tier_labels", "alcon_tier_labels", column: "tier_label_id", name: "alcon_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_plan_tier_labels", "healthplan", name: "alcon_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_plan_tier_labels", "tier", name: "alcon_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_publish_plan_bold", "healthplan", column: "healthplanid_fk", name: "alcon_publish_plan_bold_healthplanid_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_tier_label", "tier", column: "tier_id_fk", name: "alcon_tier_label_tier_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcon_tier_labels", "tier", name: "alcon_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alcondrugplanform", "alconformulary", column: "formularyfid", primary_key: "entityid", name: "alcondrugplanform_formularyfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alconformulary", "alcon_users", column: "userfid", name: "alconformulary_userfid_fkey", on_update: :cascade
  add_foreign_key "alconformulary", "alconmsa", column: "msafid", name: "alconformulary_msafid_fkey", on_update: :cascade
  add_foreign_key "alconformulary", "drugclass", column: "drugclassfid", name: "alconformulary_drugclassfid_fkey", on_update: :cascade
  add_foreign_key "alconformulary", "state", column: "statefid", name: "alconformulary_statefid_fkey", on_update: :cascade
  add_foreign_key "alconmsastate", "alconmsa", column: "msafid", name: "alconmsastate_msafid_fkey", on_update: :cascade
  add_foreign_key "alconmsastate", "state", column: "statefid", name: "alconmsastate_statefid_fkey", on_update: :cascade
  add_foreign_key "allergan_formularies", "allergan_users", column: "site_user_id", name: "allergan_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "allergan_formularies", "drugclass", column: "drug_class_id", name: "allergan_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "allergan_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "allergan_formularies_template_fk", on_update: :cascade
  add_foreign_key "allergan_formularies", "state", name: "allergan_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "allergan_plan_drug_settings", "allergan_users", column: "site_user_id", name: "allergan_plan_drug_settings_site_user_id_fk", on_update: :cascade
  add_foreign_key "allergan_plan_drug_settings", "drug", name: "allergan_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "allergan_plan_drug_settings", "healthplan", name: "allergan_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "allergan_plan_drug_settings", "state", name: "allergan_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "allergan_plan_tier_labels", "allergan_tier_labels", column: "tier_label_id", name: "allergan_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "allergan_plan_tier_labels", "healthplan", name: "allergan_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "allergan_plan_tier_labels", "tier", name: "allergan_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "allergan_tier_labels", "tier", name: "allergan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "axcanformulary", "axcanuser", column: "userfid", primary_key: "entityid", name: "axcanformulary_userfid_fkey", on_update: :cascade
  add_foreign_key "axcanformulary", "drugclass", column: "drugclassfid", name: "axcanformulary_drugclassfid_fkey", on_update: :cascade
  add_foreign_key "axcanformulary", "state", column: "statefid", name: "axcanformulary_statefid_fkey", on_update: :cascade
  add_foreign_key "az_formularies", "az_formularies", column: "formulary_id_pg1", name: "formulary_id_pg1_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "az_formularies", "az_formularies", column: "formulary_id_pg2", name: "formulary_id_pg2_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "az_formularies", "az_users", column: "user_id", name: "az_formularies_user_id_fk", on_update: :cascade
  add_foreign_key "az_formularies", "county", name: "az_formularies_county_id_fk", on_update: :cascade
  add_foreign_key "az_formularies", "drugclass", column: "drug_class_id", name: "az_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "az_formularies", "metrostatarea", column: "msa_id", name: "az_formularies_msa_id_fk", on_update: :cascade
  add_foreign_key "az_formularies", "state", name: "az_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "az_formulary_batches", "ff_formulary_batch_status", column: "ff_formulary_batch_status_code", primary_key: "code", name: "az_formulary_batches_status_code_fk", on_update: :cascade
  add_foreign_key "az_msa_names", "az_users", column: "user_id", name: "az_msa_names_user_id_fk", on_update: :cascade
  add_foreign_key "az_msa_names", "metrostatarea", column: "msa_id", name: "az_msa_names_msa_id_fk", on_update: :cascade
  add_foreign_key "az_plan_drug_options", "az_users", column: "created_by", name: "az_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "az_plan_drug_options", "az_users", column: "updated_by", name: "az_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "az_plan_drug_settings", "az_plan_drug_options", column: "plan_drug_option_id", name: "az_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "az_plan_drug_settings", "az_users", column: "created_by", name: "az_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "az_plan_drug_settings", "az_users", column: "updated_by", name: "az_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "az_plan_drug_settings", "drug", name: "az_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "az_plan_drug_settings", "healthplan", name: "az_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "az_plan_drug_settings", "state", name: "az_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "az_plan_tier_label", "az_tier_label", column: "tier_label_id_fk", name: "az_plan_tier_label_tier_label_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "az_plan_tier_label", "healthplan", column: "healthplan_id_fk", name: "az_plan_tier_label_healthplan_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "az_plan_tier_label", "tier", column: "tier_id_fk", name: "az_plan_tier_label_tier_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "az_tier_label", "tier", column: "tier_id_fk", name: "az_tier_label_tier_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "az_top_account_providers", "az_top_accounts", name: "az_top_account_providers_account_id_fk", on_update: :cascade
  add_foreign_key "az_top_account_providers", "provider", name: "az_top_account_providers_provider_id_fk", on_update: :cascade
  add_foreign_key "bayer_formularies", "bayer_users", column: "site_user_id", name: "bayer_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "bayer_formularies", "drugclass", column: "drug_class_id", name: "bayer_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "bayer_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "bayer_formularies_template_fk", on_update: :cascade
  add_foreign_key "bayer_formularies", "state", name: "bayer_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "bayer_plan_drug_options", "bayer_users", column: "created_by", name: "bayer_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "bayer_plan_drug_options", "bayer_users", column: "updated_by", name: "bayer_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "bayer_plan_drug_settings", "bayer_plan_drug_options", column: "plan_drug_option_id", name: "bayer_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bayer_plan_drug_settings", "bayer_users", column: "created_by", name: "bayer_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "bayer_plan_drug_settings", "bayer_users", column: "updated_by", name: "bayer_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "bayer_plan_drug_settings", "drug", name: "bayer_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bayer_plan_drug_settings", "healthplan", name: "bayer_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bayer_plan_drug_settings", "state", name: "bayer_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bayer_plan_tier_labels", "bayer_tier_labels", column: "tier_label_id", name: "bayer_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bayer_plan_tier_labels", "healthplan", name: "bayer_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bayer_plan_tier_labels", "tier", name: "bayer_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bayer_tier_labels", "tier", name: "bayer_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bl_formularies", "bl_users", column: "site_user_id", name: "bl_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "bl_formularies", "drugclass", column: "drug_class_id", name: "bl_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "bl_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "bl_formularies_template_fk", on_update: :cascade
  add_foreign_key "bl_formularies", "state", name: "bl_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "bl_plan_drug_options", "bl_users", column: "created_by", name: "bl_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "bl_plan_drug_options", "bl_users", column: "updated_by", name: "bl_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "bl_plan_drug_settings", "bl_plan_drug_options", column: "plan_drug_option_id", name: "bl_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bl_plan_drug_settings", "bl_users", column: "created_by", name: "bl_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "bl_plan_drug_settings", "bl_users", column: "updated_by", name: "bl_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "bl_plan_drug_settings", "drug", name: "bl_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bl_plan_drug_settings", "healthplan", name: "bl_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bl_plan_drug_settings", "state", name: "bl_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bl_plan_tier_labels", "bl_tier_labels", column: "tier_label_id", name: "bl_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bl_plan_tier_labels", "healthplan", name: "bl_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bl_plan_tier_labels", "tier", name: "bl_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bl_tier_labels", "tier", name: "bl_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_formularies", "drugclass", column: "drug_class_id", name: "bms_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "bms_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "bms_formularies_template_fk", on_update: :cascade
  add_foreign_key "bms_formularies", "sa_formularies", name: "bms_formularies_sa_formulary_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_formularies", "state", name: "bms_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "bms_formulary_approvals", "bms_formularies", column: "formulary_id", name: "bms_formulary_approvals_formulary_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_formulary_approvals", "bms_users", column: "user_id", name: "bms_formulary_approvals_user_id_fk", on_update: :cascade
  add_foreign_key "bms_formulary_exports", "bms_formularies", column: "formulary_id", name: "bms_formulary_exports_formulary_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_formulary_order_defaults", "bms_roles", column: "role_id", name: "bms_formulary_order_defaults_role_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_formulary_order_defaults", "bms_users", column: "user_id", name: "bms_formulary_order_defaults_user_id_fk", on_update: :cascade
  add_foreign_key "bms_formulary_order_defaults", "ff_publisher_template", column: "publisher_template_id", name: "bms_formulary_order_defaults_template_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_formulary_orders", "bms_formularies", column: "formulary_id", name: "bms_formulary_orders_formulary_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_formulary_orders", "bms_users", column: "user_id", name: "bms_formulary_order_addresses_user_id_fk", on_update: :cascade
  add_foreign_key "bms_formulary_orders", "bms_users", column: "user_id", name: "bms_formulary_orders_user_id_fk", on_update: :cascade
  add_foreign_key "bms_msa_names", "bms_users", column: "user_id", name: "az_msa_names_user_id_fk", on_update: :cascade
  add_foreign_key "bms_msa_names", "metrostatarea", column: "msa_id", name: "az_msa_names_msa_id_fk", on_update: :cascade
  add_foreign_key "bms_pdf_access_archive", "bms_formularies", column: "formulary_id", name: "bms_pdf_access_archive_formulary_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_pdf_access_archive", "bms_users", column: "user_id", name: "bms_pdf_access_archive_user_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_plan_drug_settings", "bms_users", column: "user_id", name: "bms_plan_drug_settings_site_user_id_fk", on_update: :cascade
  add_foreign_key "bms_plan_drug_settings", "drug", name: "bms_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_plan_drug_settings", "healthplan", name: "bms_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_plan_drug_settings", "state", name: "bms_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_plan_names", "bms_users", column: "user_id", name: "az_plan_names_user_id_fk", on_update: :cascade
  add_foreign_key "bms_plan_names", "healthplan", name: "az_plan_names_msa_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_plan_tier_labels", "bms_tier_labels", column: "tier_label_id", name: "bms_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_plan_tier_labels", "healthplan", name: "bms_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_plan_tier_labels", "tier", name: "bms_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_provider_rollup", "bms_users", column: "user_id", name: "bms_provider_rollup_user_id_fk", on_update: :cascade
  add_foreign_key "bms_provider_rollup", "provider", name: "bms_provider_rollup_provider_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "bms_tier_labels", "tier", name: "bms_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cephalon_formularies", "cephalon_users", column: "site_user_id", name: "cephalon_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "cephalon_formularies", "drugclass", column: "drug_class_id", name: "cephalon_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "cephalon_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "cephalon_formularies_template_fk", on_update: :cascade
  add_foreign_key "cephalon_formularies", "state", name: "cephalon_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "cephalon_plan_drug_settings", "cephalon_users", column: "site_user_id", name: "cephalon_plan_drug_settings_site_user_id_fk", on_update: :cascade
  add_foreign_key "cephalon_plan_drug_settings", "drug", name: "cephalon_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cephalon_plan_drug_settings", "healthplan", name: "cephalon_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cephalon_plan_drug_settings", "state", name: "cephalon_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cephalon_plan_tier_labels", "cephalon_tier_labels", column: "tier_label_id", name: "cephalon_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cephalon_plan_tier_labels", "healthplan", name: "cephalon_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cephalon_plan_tier_labels", "tier", name: "cephalon_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cephalon_tier_labels", "tier", name: "cephalon_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "contact", "contacttype", column: "contacttypefid", name: "contact_contacttypefid_fkey"
  add_foreign_key "cubist_formularies", "cubist_users", column: "site_user_id", name: "cubist_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "cubist_formularies", "drugclass", column: "drug_class_id", name: "cubist_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "cubist_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "cubist_formularies_template_fk", on_update: :cascade
  add_foreign_key "cubist_formularies", "state", name: "cubist_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "cubist_plan_drug_options", "cubist_users", column: "created_by", name: "cubist_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "cubist_plan_drug_options", "cubist_users", column: "updated_by", name: "cubist_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "cubist_plan_drug_settings", "cubist_plan_drug_options", column: "plan_drug_option_id", name: "cubist_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cubist_plan_drug_settings", "cubist_users", column: "created_by", name: "cubist_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "cubist_plan_drug_settings", "cubist_users", column: "updated_by", name: "cubist_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "cubist_plan_drug_settings", "drug", name: "cubist_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cubist_plan_drug_settings", "healthplan", name: "cubist_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cubist_plan_drug_settings", "state", name: "cubist_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cubist_plan_tier_labels", "cubist_tier_labels", column: "tier_label_id", name: "cubist_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cubist_plan_tier_labels", "healthplan", name: "cubist_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cubist_plan_tier_labels", "tier", name: "cubist_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cubist_tier_labels", "tier", name: "cubist_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dey_formularies", "dey_users", column: "site_user_id", name: "dey_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "dey_formularies", "drugclass", column: "drug_class_id", name: "dey_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "dey_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "dey_formularies_template_fk", on_update: :cascade
  add_foreign_key "dey_formularies", "state", name: "dey_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "dey_plan_drug_options", "dey_users", column: "created_by", name: "dey_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "dey_plan_drug_options", "dey_users", column: "updated_by", name: "dey_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "dey_plan_drug_settings", "dey_plan_drug_options", column: "plan_drug_option_id", name: "dey_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dey_plan_drug_settings", "dey_users", column: "created_by", name: "dey_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "dey_plan_drug_settings", "dey_users", column: "updated_by", name: "dey_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "dey_plan_drug_settings", "drug", name: "dey_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dey_plan_drug_settings", "healthplan", name: "dey_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dey_plan_drug_settings", "state", name: "dey_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dey_plan_tier_labels", "dey_tier_labels", column: "tier_label_id", name: "dey_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dey_plan_tier_labels", "healthplan", name: "dey_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dey_plan_tier_labels", "tier", name: "dey_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dey_tier_labels", "tier", name: "dey_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dma_state", "dma", name: "dma_state_dma_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dma_state", "state", name: "dma_state_state_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dma_zipcode", "dma", name: "dma_zipcode_dma_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dma_zipcode", "zipcode", column: "dma_id", name: "dma_zipcode_zipcode_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "drug", "drug", column: "genericdrugfid", name: "drug_genericdrugfid_fkey"
  add_foreign_key "drug", "ffuser", column: "lastupdateffuserfid", primary_key: "userid", name: "drug_lastupdateffuserfid_fkey"
  add_foreign_key "drug", "manufacturer", column: "manufacturerfid", name: "drug_manufacturerfid_fkey"
  add_foreign_key "drugclass", "ffuser", column: "lastupdateffuserfid", primary_key: "userid", name: "drugclass_lastupdateffuserfid_fkey"
  add_foreign_key "drugclasstherapeuticarea", "drugclass", column: "drugclassfid", name: "drugclasstherapeuticarea_drugclassfid_fkey"
  add_foreign_key "drugclasstherapeuticarea", "therapeuticarea", column: "therapeuticareafid", name: "drugclasstherapeuticarea_therapeuticareafid_fkey"
  add_foreign_key "drugcomment", "comment", column: "commentfid", name: "drugcomment_commentfid_fkey"
  add_foreign_key "drugcomment", "drug", column: "drugfid", name: "drugcomment_drugfid_fkey"
  add_foreign_key "drugdrugclass", "drug", column: "drugfid", name: "drugdrugclass_drugfid_fkey"
  add_foreign_key "drugdrugclass", "drugclass", column: "drugclassfid", name: "drugdrugclass_drugclassfid_fkey"
  add_foreign_key "drugfactor", "drug", column: "drugfid", name: "drugfactor_drugfid_fkey"
  add_foreign_key "drugfactor", "factor", column: "factorfid", name: "drugfactor_factorfid_fkey"
  add_foreign_key "dsi_formularies", "drugclass", column: "drug_class_id", name: "dsi_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "dsi_formularies", "dsi_users", column: "site_user_id", name: "dsi_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "dsi_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "dsi_formularies_template_fk", on_update: :cascade
  add_foreign_key "dsi_formularies", "state", name: "dsi_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "dsi_plan_drug_options", "dsi_users", column: "created_by", name: "dsi_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "dsi_plan_drug_options", "dsi_users", column: "updated_by", name: "dsi_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "dsi_plan_drug_settings", "drug", name: "dsi_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dsi_plan_drug_settings", "dsi_plan_drug_options", column: "plan_drug_option_id", name: "dsi_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dsi_plan_drug_settings", "dsi_users", column: "created_by", name: "dsi_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "dsi_plan_drug_settings", "dsi_users", column: "updated_by", name: "dsi_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "dsi_plan_drug_settings", "healthplan", name: "dsi_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dsi_plan_drug_settings", "state", name: "dsi_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dsi_plan_tier_labels", "dsi_tier_labels", column: "tier_label_id", name: "dsi_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dsi_plan_tier_labels", "healthplan", name: "dsi_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dsi_plan_tier_labels", "tier", name: "dsi_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dsi_tier_labels", "tier", name: "dsi_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dsiimshealthplan", "dsiimsplan", column: "imsfid", name: "dsiimshealthplan_imsfid_fkey"
  add_foreign_key "dsiimshealthplan", "healthplan", column: "healthplanfid", name: "dsiimshealthplan_healthplanfid_fkey"
  add_foreign_key "dsiimsplan", "state", column: "statefid", name: "dsiimsplan_statefid_fkey"
  add_foreign_key "eisai_formularies", "drugclass", column: "drug_class_id", name: "eisai_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "eisai_formularies", "eisai_users", column: "site_user_id", name: "eisai_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "eisai_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "eisai_formularies_template_fk", on_update: :cascade
  add_foreign_key "eisai_formularies", "state", name: "eisai_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "eisai_plan_drug_options", "eisai_users", column: "created_by", name: "eisai_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "eisai_plan_drug_options", "eisai_users", column: "updated_by", name: "eisai_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "eisai_plan_drug_settings", "drug", name: "eisai_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eisai_plan_drug_settings", "eisai_plan_drug_options", column: "plan_drug_option_id", name: "eisai_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eisai_plan_drug_settings", "eisai_users", column: "created_by", name: "eisai_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "eisai_plan_drug_settings", "eisai_users", column: "updated_by", name: "eisai_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "eisai_plan_drug_settings", "healthplan", name: "eisai_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eisai_plan_drug_settings", "state", name: "eisai_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eisai_plan_tier_labels", "eisai_tier_labels", column: "tier_label_id", name: "eisai_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eisai_plan_tier_labels", "healthplan", name: "eisai_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eisai_plan_tier_labels", "tier", name: "eisai_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eisai_tier_labels", "tier", name: "eisai_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "epocrates_formularies", "drugclass", column: "drug_class_id", name: "epocrates_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "epocrates_formularies", "epocrates_users", column: "site_user_id", name: "epocrates_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "epocrates_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "epocrates_formularies_template_fk", on_update: :cascade
  add_foreign_key "epocrates_formularies", "state", name: "epocrates_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "epocrates_plan_drug_options", "epocrates_users", column: "created_by", name: "epocrates_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "epocrates_plan_drug_options", "epocrates_users", column: "updated_by", name: "epocrates_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "epocrates_plan_drug_settings", "drug", name: "epocrates_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "epocrates_plan_drug_settings", "epocrates_plan_drug_options", column: "plan_drug_option_id", name: "epocrates_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "epocrates_plan_drug_settings", "epocrates_users", column: "created_by", name: "epocrates_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "epocrates_plan_drug_settings", "epocrates_users", column: "updated_by", name: "epocrates_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "epocrates_plan_drug_settings", "healthplan", name: "epocrates_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "epocrates_plan_drug_settings", "state", name: "epocrates_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "epocrates_plan_tier_labels", "epocrates_tier_labels", column: "tier_label_id", name: "epocrates_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "epocrates_plan_tier_labels", "healthplan", name: "epocrates_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "epocrates_plan_tier_labels", "tier", name: "epocrates_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "epocrates_tier_labels", "tier", name: "epocrates_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eurand_formularies", "drugclass", column: "drug_class_id", name: "eurand_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "eurand_formularies", "eurand_users", column: "site_user_id", name: "eurand_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "eurand_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "eurand_formularies_template_fk", on_update: :cascade
  add_foreign_key "eurand_formularies", "state", name: "eurand_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "eurand_plan_drug_options", "eurand_users", column: "created_by", name: "eurand_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "eurand_plan_drug_options", "eurand_users", column: "updated_by", name: "eurand_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "eurand_plan_drug_settings", "drug", name: "eurand_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eurand_plan_drug_settings", "eurand_plan_drug_options", column: "plan_drug_option_id", name: "eurand_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eurand_plan_drug_settings", "eurand_users", column: "created_by", name: "eurand_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "eurand_plan_drug_settings", "eurand_users", column: "updated_by", name: "eurand_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "eurand_plan_drug_settings", "healthplan", name: "eurand_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eurand_plan_drug_settings", "state", name: "eurand_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eurand_plan_tier_labels", "eurand_tier_labels", column: "tier_label_id", name: "eurand_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eurand_plan_tier_labels", "healthplan", name: "eurand_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eurand_plan_tier_labels", "tier", name: "eurand_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "eurand_tier_labels", "tier", name: "eurand_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "feqcriteriaentry", "criteriaentry", column: "criteriaentryfid", name: "feqcriteriaentry_criteriaentryfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "feqcriteriaentry", "drugclass", column: "drugclassfid", name: "feqcriteriaentry_drugclassfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "feqcriteriaentry", "formularyentryqualifier", column: "feqfid", name: "feqcriteriaentry_feqfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "feqcriteriaentry", "healthplan", column: "healthplanfid", name: "feqcriteriaentry_healthplanfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_formulary_batch_templates", "ff_publisher_template", name: "ff_formulary_batch_templates_ff_publisher_template_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_formulary_batch_templates", "ff_site", column: "site_id", name: "ff_formulary_batch_templates_site_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_formulary_batch_tracks", "ff_formulary_batch_templates", name: "ff_formulary_batch_tracks_ff_formulary_batch_template_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_formulary_batch_tracks", "ff_nav_tracks", name: "ff_formulary_batch_tracks_ff_nav_track_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_provider_contact", "ffuser", column: "creatorid_fk", primary_key: "userid", name: "ff_provider_contact_creatorid_fk_fkey", on_update: :cascade
  add_foreign_key "ff_provider_contact", "ffuser", column: "modbyid_fk", primary_key: "userid", name: "ff_provider_contact_modbyid_fk_fkey", on_update: :cascade
  add_foreign_key "ff_provider_contact", "provider", column: "providerid_fk", name: "ff_provider_contact_providerid_fk_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "ff_provider_contact", "state", column: "state_fk", name: "ff_provider_contact_state_fk_fkey", on_update: :cascade
  add_foreign_key "ff_provider_contact_notes", "ff_provider_contact", column: "contactid_fk", name: "ff_provider_contact_notes_contactid_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_provider_contact_notes", "ffuser", column: "creatorid_fk", primary_key: "userid", name: "ff_provider_contact_notes_creatorid_fk_fkey", on_update: :cascade
  add_foreign_key "ff_publisher_dependent_templates", "ff_publisher_template", column: "dependent_template", primary_key: "template", name: "ff_publisher_dependent_templates_dependent_template_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_publisher_dependent_templates", "ff_publisher_template", name: "ff_publisher_dependent_templates_ff_publisher_template_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_publisher_template", "drugclass", name: "ff_publisher_template_drug_class_id_fk", on_update: :cascade, on_delete: :nullify
  add_foreign_key "ff_publisher_template", "ff_site", column: "siteid_fk", name: "ff_publisher_template_site_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_publisher_tracks", "ff_nav_tracks", name: "ff_publisher_tracks_nav_track_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_publisher_tracks", "ff_publisher_template", name: "ff_publisher_tracks_template_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_view_formulary_templates", "ff_site", column: "site_id", name: "ff_view_formulary_templates_site_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_view_formulary_tracks", "ff_nav_tracks", name: "ff_view_formulary_tracks_ff_nav_track_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ff_view_formulary_tracks", "ff_view_formulary_templates", name: "ff_view_formulary_tracks_ff_view_formulary_template_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ffuserrole", "ffrole", column: "ffrolefid", name: "ffuserrole_ffrolefid_fkey"
  add_foreign_key "ffuserrole", "ffuser", column: "ffuserfid", primary_key: "userid", name: "ffuserrole_ffuserfid_fkey"
  add_foreign_key "fingertipformulary", "drug", column: "spotlightdrugfid", name: "fingertipformulary_spotlightdrugfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "fingertipformulary", "drugclass", column: "drugclassfid", name: "fingertipformulary_drugclassfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "fingertipformulary", "ffuser", column: "userfid", primary_key: "userid", name: "fingertipformulary_userfid_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "fingertipformulary", "state", column: "statefid", name: "fingertipformulary_statefid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "formulary", "ffuser", column: "lastupdateffuserfid", primary_key: "userid", name: "formulary_lastupdateffuserfid_fkey"
  add_foreign_key "formulary", "tier", column: "defaultbrandtierfid", name: "formulary_defaultbrandtierfid_fkey"
  add_foreign_key "formulary", "tier", column: "defaultgenerictierfid", name: "formulary_defaultgenerictierfid_fkey"
  add_foreign_key "formulary_assignments", "ffuser", column: "formulary_assigned_to_id", primary_key: "userid", name: "fk_formulary_assignments_assigned_to_id"
  add_foreign_key "formulary_assignments", "healthplan", column: "health_plan_display_id", primary_key: "displayid", name: "fk_formulary_assignments_health_plan_display_id"
  add_foreign_key "formulary_assignments", "healthplan", column: "health_plan_id", name: "fk_formulary_assignments_health_plan_id"
  add_foreign_key "formularyentry", "drug", column: "drugfid", name: "formularyentry_drugfid_fkey"
  add_foreign_key "formularyentry", "formulary", column: "formularyfid", name: "formularyentry_formularyfid_fkey"
  add_foreign_key "formularyentry", "tier", column: "tierfid", name: "formularyentry_tierfid_fkey"
  add_foreign_key "formularyentryarchive", "formularyarchive", column: "formularyfid", name: "formularyentryarchive_formularyfid_fkey"
  add_foreign_key "formularyentryqualifier", "formularyentry", column: "formularyentryfid", name: "formularyentryqualifier_formularyentryfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "formularyentryqualifier", "qualifier", column: "qualifierfid", name: "formularyentryqualifier_qualifierfid_fkey"
  add_foreign_key "formularyentryqualifierarchive", "formularyarchive", column: "formularyfid", name: "formularyentryqualifierarchive_formularyfid_fkey"
  add_foreign_key "formularyentryqualifierarchive", "formularyentryarchive", column: "formularyentryfid", name: "formularyentryqualifierarchive_formularyentryfid_fkey"
  add_foreign_key "galderma_plan_exclusion", "galdermauser", column: "create_user_id", primary_key: "entityid", name: "galderma_plan_exclusion_create_user_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "galderma_plan_exclusion", "galdermauser", column: "update_user_id", primary_key: "entityid", name: "galderma_plan_exclusion_update_user_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "galderma_plan_exclusion", "healthplan", name: "galderma_plan_exclusion_healthplan_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "galdermaformulary", "drugclass", column: "drugclassfid", name: "galdermaformulary_drugclassfid_fkey", on_update: :cascade
  add_foreign_key "galdermaformulary", "galdermauser", column: "userfid", primary_key: "entityid", name: "galdermaformulary_userfid_fkey", on_update: :cascade
  add_foreign_key "galdermaformulary", "state", column: "statefid", name: "galdermaformulary_statefid_fkey", on_update: :cascade
  add_foreign_key "gilead_formularies", "drugclass", column: "drug_class_id", name: "gilead_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "gilead_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "gilead_formularies_template_fk", on_update: :cascade
  add_foreign_key "gilead_formularies", "gilead_users", column: "site_user_id", name: "gilead_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "gilead_formularies", "state", name: "gilead_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "gilead_plan_drug_options", "gilead_users", column: "created_by", name: "gilead_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "gilead_plan_drug_options", "gilead_users", column: "updated_by", name: "gilead_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "gilead_plan_drug_settings", "drug", name: "gilead_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gilead_plan_drug_settings", "gilead_plan_drug_options", column: "plan_drug_option_id", name: "gilead_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gilead_plan_drug_settings", "gilead_users", column: "created_by", name: "gilead_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "gilead_plan_drug_settings", "gilead_users", column: "updated_by", name: "gilead_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "gilead_plan_drug_settings", "healthplan", name: "gilead_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gilead_plan_drug_settings", "state", name: "gilead_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gilead_plan_tier_labels", "gilead_tier_labels", column: "tier_label_id", name: "gilead_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gilead_plan_tier_labels", "healthplan", name: "gilead_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gilead_plan_tier_labels", "tier", name: "gilead_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gilead_tier_labels", "tier", name: "gilead_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gsk_dma_names", "dma", name: "gsk_dma_name_dma_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gsk_dma_names", "gsk_users", column: "updated_by", name: "gsk_dma_name_updated_by_fk", on_update: :cascade, on_delete: :nullify
  add_foreign_key "gsk_formularies", "dma", name: "gsk_formularies_dma_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gsk_formularies", "drugclass", column: "drug_class_id", name: "gsk_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "gsk_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "gsk_formularies_template_fk", on_update: :cascade
  add_foreign_key "gsk_formularies", "gsk_users", column: "site_user_id", name: "gsk_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "gsk_formularies", "state", name: "gsk_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "gsk_formulary_order_addresses", "gsk_formulary_orders", column: "site_formulary_order_id", name: "gsk_formulary_order_addresses_site_formulary_order_id_fk", on_update: :cascade
  add_foreign_key "gsk_formulary_order_addresses", "gsk_users", column: "site_user_id", name: "gsk_formulary_order_addresses_site_user_id_fk", on_update: :cascade
  add_foreign_key "gsk_formulary_order_addresses", "state", name: "gsk_formulary_order_addresses_state_id_fk", on_update: :cascade
  add_foreign_key "gsk_formulary_order_defaults", "ff_publisher_template", name: "gsk_formulary_order_defaults_ff_publisher_template_id_fk", on_update: :cascade
  add_foreign_key "gsk_formulary_order_defaults", "gsk_roles", column: "site_role_id", name: "gsk_formulary_order_defaults_site_role_id_fk", on_update: :cascade
  add_foreign_key "gsk_formulary_order_defaults", "gsk_users", column: "updated_by", name: "gsk_formulary_order_defaults_updated_by_fk", on_update: :cascade
  add_foreign_key "gsk_formulary_order_users", "drug", name: "gsk_formulary_order_users_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gsk_formulary_order_users", "gsk_users", column: "site_user_id", name: "gsk_formulary_order_users_site_user_id_fk", on_update: :cascade
  add_foreign_key "gsk_formulary_order_users", "gsk_users", column: "updated_by", name: "gsk_formulary_order_users_updated_by_fk", on_update: :cascade
  add_foreign_key "gsk_formulary_orders", "gsk_formularies", column: "site_formulary_id", name: "gsk_formulary_orders_site_formulary_id_fk", on_update: :cascade
  add_foreign_key "gsk_formulary_orders", "gsk_users", column: "site_user_id", name: "gsk_formulary_orders_site_user_id_fk", on_update: :cascade
  add_foreign_key "gsk_plan_exclusions", "drug", name: "gsk_plan_exclusions_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gsk_plan_exclusions", "drugclass", name: "gsk_plan_exclusions_drugclass_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gsk_plan_exclusions", "gsk_users", column: "site_user_id", name: "gsk_plan_exclusions_site_user_id_fk", on_update: :cascade
  add_foreign_key "gsk_plan_exclusions", "healthplan", name: "gsk_plan_exclusions_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gsk_plan_exclusions", "provider", name: "gsk_plan_exclusions_provider_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gsk_provider_custom", "provider", name: "gsk_provider_custom_provider_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "gsk_provider_exclusions", "provider", name: "gsk_provider_exclusions_provider_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "healthplan", "healthplantype", column: "healthplantypefid", name: "healthplan_healthplantypefid_fkey"
  add_foreign_key "healthplan", "pbm", column: "pbmhealthplanfid", name: "healthplan_pbmhealthplanfid_fkey"
  add_foreign_key "healthplan", "provider", column: "providerfid", name: "healthplan_providerfid_fkey"
  add_foreign_key "healthplan_countylives_staging", "healthplan", column: "healthplanfid", name: "healthplan_countylives_staging_healthplanfid_fkey"
  add_foreign_key "healthplanaddress", "address", column: "addressfid", name: "healthplanaddress_addressfid_fkey"
  add_foreign_key "healthplanaddress", "healthplan", column: "healthplanfid", name: "healthplanaddress_healthplanfid_fkey"
  add_foreign_key "healthplancomment", "comment", column: "commentfid", name: "healthplancomment_commentfid_fkey"
  add_foreign_key "healthplancomment", "healthplan", column: "healthplanfid", name: "healthplancomment_healthplanfid_fkey"
  add_foreign_key "healthplancontact", "contact", column: "contactfid", name: "healthplancontact_contactfid_fkey"
  add_foreign_key "healthplancontact", "healthplan", column: "healthplanfid", name: "healthplancontact_healthplanfid_fkey"
  add_foreign_key "healthplanlivesarchive", "state", column: "statefid", name: "healthplanlivesarchive_statefid_fkey"
  add_foreign_key "healthplanstate", "healthplan", column: "healthplanfid", name: "healthplanstate_healthplanfid_fkey"
  add_foreign_key "healthplanstate", "state", column: "statefid", name: "healthplanstate_statefid_fkey"
  add_foreign_key "importcontractenrollment", "importbatch", column: "importbatchfid", name: "importcontractenrollment_importbatchfid_fkey"
  add_foreign_key "importcontractenrollment", "importcontract", column: "importcontractfid", name: "importcontractenrollment_importcontractfid_fkey"
  add_foreign_key "importcontractenrollment", "state", column: "statefid", name: "importcontractenrollment_statefid_fkey"
  add_foreign_key "importcontractplan", "healthplan", column: "healthplanfid", name: "importcontractplan_healthplanfid_fkey"
  add_foreign_key "importcontractplan", "importmapping", column: "importmappingfid", name: "importcontractplan_importmappingfid_fkey"
  add_foreign_key "importexception", "importbatch", column: "importbatchfid", name: "importexception_importbatchfid_fkey"
  add_foreign_key "importmapping", "importbatch", column: "importbatchfid", name: "importmapping_importbatchfid_fkey"
  add_foreign_key "importmapping", "importcontract", column: "importcontractfid", name: "importmapping_importcontractfid_fkey"
  add_foreign_key "imshealthplan", "healthplan", column: "healthplanfid", name: "imshealthplan_healthplanfid_fkey"
  add_foreign_key "imshealthplan", "imsplan", column: "imsfid", name: "imshealthplan_imsfid_fkey"
  add_foreign_key "imshealthplancomment", "comment", column: "commentfid", name: "imshealthplancomment_commentfid_fkey"
  add_foreign_key "imshealthplancomment", "healthplan", column: "healthplanfid", name: "imshealthplancomment_healthplanfid_fkey"
  add_foreign_key "jnj_formularies", "drugclass", column: "drug_class_id", name: "jnj_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "jnj_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "jnj_formularies_template_fk", on_update: :cascade
  add_foreign_key "jnj_formularies", "jnj_users", column: "site_user_id", name: "jnj_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "jnj_formularies", "state", name: "jnj_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "jnj_plan_tier_labels", "healthplan", name: "jnj_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "jnj_plan_tier_labels", "jnj_tier_labels", column: "tier_label_id", name: "jnj_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "jnj_plan_tier_labels", "tier", name: "jnj_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "jnj_tier_labels", "tier", name: "jnj_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "lilly_formularies", "drugclass", column: "drug_class_id", name: "lilly_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "lilly_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "lilly_formularies_template_fk", on_update: :cascade
  add_foreign_key "lilly_formularies", "lilly_users", column: "site_user_id", name: "lilly_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "lilly_formularies", "state", name: "lilly_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "lilly_plan_drug_options", "lilly_users", column: "created_by", name: "lilly_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "lilly_plan_drug_options", "lilly_users", column: "updated_by", name: "lilly_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "lilly_plan_drug_settings", "drug", name: "lilly_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "lilly_plan_drug_settings", "healthplan", name: "lilly_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "lilly_plan_drug_settings", "lilly_plan_drug_options", column: "plan_drug_option_id", name: "lilly_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "lilly_plan_drug_settings", "lilly_users", column: "created_by", name: "lilly_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "lilly_plan_drug_settings", "lilly_users", column: "updated_by", name: "lilly_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "lilly_plan_drug_settings", "state", name: "lilly_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "lilly_plan_tier_labels", "healthplan", name: "lilly_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "lilly_plan_tier_labels", "lilly_tier_labels", column: "tier_label_id", name: "lilly_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "lilly_plan_tier_labels", "tier", name: "lilly_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "lilly_tier_labels", "tier", name: "lilly_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "mallinckrodtdrugplanform", "mallinckrodtformulary", column: "formularyfid", primary_key: "entityid", name: "mallinckrodtdrugplanform_formularyfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "mallinckrodtformulary", "drugclass", column: "drugclassfid", name: "mallinckrodtformulary_drugclassfid_fkey", on_update: :cascade
  add_foreign_key "mallinckrodtformulary", "mallinckrodtmsa", column: "msafid", name: "mallinckrodtformulary_msafid_fkey", on_update: :cascade
  add_foreign_key "mallinckrodtformulary", "mallinckrodtuser", column: "userfid", primary_key: "entityid", name: "mallinckrodtformulary_userfid_fkey", on_update: :cascade
  add_foreign_key "mallinckrodtformulary", "state", column: "statefid", name: "mallinckrodtformulary_statefid_fkey", on_update: :cascade
  add_foreign_key "mallinckrodtmsahealthplan", "healthplan", column: "healthplanfid", name: "mallinckrodtmsahealthplan_healthplanfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "mallinckrodtmsahealthplan", "mallinckrodtmsa", column: "msafid", name: "mallinckrodtmsahealthplan_msafid_fkey", on_update: :cascade
  add_foreign_key "mallinckrodtmsahealthplan", "state", column: "statefid", name: "mallinckrodtmsahealthplan_statefid_fkey", on_update: :cascade
  add_foreign_key "mallinckrodtmsastate", "mallinckrodtmsa", column: "msafid", name: "mallinckrodtmsastate_msafid_fkey", on_update: :cascade
  add_foreign_key "mallinckrodtmsastate", "state", column: "statefid", name: "mallinckrodtmsastate_statefid_fkey", on_update: :cascade
  add_foreign_key "merck_formularies", "drugclass", column: "drug_class_id", name: "merck_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "merck_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "merck_formularies_template_fk", on_update: :cascade
  add_foreign_key "merck_formularies", "merck_users", column: "site_user_id", name: "merck_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "merck_formularies", "state", name: "merck_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "merck_plan_drug_options", "merck_users", column: "created_by", name: "merck_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "merck_plan_drug_options", "merck_users", column: "updated_by", name: "merck_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "merck_plan_drug_settings", "drug", name: "merck_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "merck_plan_drug_settings", "healthplan", name: "merck_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "merck_plan_drug_settings", "merck_plan_drug_options", column: "plan_drug_option_id", name: "merck_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "merck_plan_drug_settings", "merck_users", column: "created_by", name: "merck_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "merck_plan_drug_settings", "merck_users", column: "updated_by", name: "merck_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "merck_plan_drug_settings", "state", name: "merck_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "merck_plan_tier_labels", "healthplan", name: "merck_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "merck_plan_tier_labels", "merck_tier_labels", column: "tier_label_id", name: "merck_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "merck_plan_tier_labels", "tier", name: "merck_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "merck_tier_labels", "tier", name: "merck_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "nexiumstats", "nexiumuser", column: "nexiumuserfid", name: "nexiumstats_nexiumuserfid_fkey"
  add_foreign_key "nexiumuserhealthplan", "nexiumuser", column: "nexiumuserfid", name: "nexiumuserhealthplan_nexiumuserfid_fkey"
  add_foreign_key "nexiumusersession", "nexiumuser", column: "nexiumuserfid", name: "nexiumusersession_nexiumuserfid_fkey"
  add_foreign_key "novartis_formularies_old", "drugclass", column: "drug_class_id", name: "novartis_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "novartis_formularies_old", "ff_publisher_template", column: "template", primary_key: "template", name: "novartis_formularies_template_fk", on_update: :cascade
  add_foreign_key "novartis_formularies_old", "metrostatarea", column: "msa_id", name: "novartis_formularies_msa_id_fkey", on_update: :cascade
  add_foreign_key "novartis_formularies_old", "novartis_users", column: "site_user_id", name: "novartis_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "novartis_formularies_old", "state", name: "novartis_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "novartis_plan_tier_labels", "healthplan", name: "novartis_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novartis_plan_tier_labels", "novartis_tier_labels", column: "tier_label_id", name: "novartis_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novartis_plan_tier_labels", "tier", name: "novartis_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novartis_provider_custom", "provider", name: "novartis_provider_custom_provider_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novartis_provider_plans", "healthplan", name: "novartis_provider_plans_healthplan_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novartis_provider_plans", "novartis_provider_custom", column: "custom_provider_id", name: "novartis_provider_plans_custom_provider_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novartis_provider_plans", "provider", name: "novartis_provider_plans_provider_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novartis_tier_labels", "tier", name: "novartis_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novo_formularies", "drugclass", column: "drug_class_id", name: "novo_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "novo_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "novo_formularies_template_fk", on_update: :cascade
  add_foreign_key "novo_formularies", "novo_users", column: "site_user_id", name: "novo_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "novo_formularies", "state", name: "novo_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "novo_plan_drug_options", "novo_users", column: "created_by", name: "novo_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "novo_plan_drug_options", "novo_users", column: "updated_by", name: "novo_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "novo_plan_drug_settings", "drug", name: "novo_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novo_plan_drug_settings", "healthplan", name: "novo_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novo_plan_drug_settings", "novo_plan_drug_options", column: "plan_drug_option_id", name: "novo_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novo_plan_drug_settings", "novo_users", column: "created_by", name: "novo_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "novo_plan_drug_settings", "novo_users", column: "updated_by", name: "novo_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "novo_plan_drug_settings", "state", name: "novo_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novo_plan_tier_labels", "healthplan", name: "novo_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novo_plan_tier_labels", "novo_tier_labels", column: "tier_label_id", name: "novo_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novo_plan_tier_labels", "tier", name: "novo_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "novo_tier_labels", "tier", name: "novo_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_formularies", "drugclass", column: "drug_class_id", name: "otsuka_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "otsuka_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "otsuka_formularies_template_fk", on_update: :cascade
  add_foreign_key "otsuka_formularies", "otsuka_users", column: "site_user_id", name: "otsuka_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "otsuka_formularies", "state", name: "otsuka_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "otsuka_formulary_order_defaults", "ff_publisher_template", column: "publisher_template_id", name: "otsuka_formulary_order_defaults_template_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_formulary_order_defaults", "otsuka_roles", column: "role_id", name: "otsuka_formulary_order_defaults_role_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_formulary_order_defaults", "otsuka_users", column: "user_id", name: "otsuka_formulary_order_defaults_user_id_fk", on_update: :cascade
  add_foreign_key "otsuka_formulary_orders", "otsuka_formularies", column: "formulary_id", name: "otsuka_formulary_orders_formulary_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_formulary_orders", "otsuka_users", column: "user_id", name: "otsuka_formulary_order_addresses_user_id_fk", on_update: :cascade
  add_foreign_key "otsuka_formulary_orders", "otsuka_users", column: "user_id", name: "otsuka_formulary_orders_user_id_fk", on_update: :cascade
  add_foreign_key "otsuka_msa_names", "metrostatarea", column: "msa_id", name: "otsuka_msa_names_msa_id_fk", on_update: :cascade
  add_foreign_key "otsuka_msa_names", "otsuka_users", column: "user_id", name: "otsuka_msa_names_user_id_fk", on_update: :cascade
  add_foreign_key "otsuka_pdf_access_archive", "otsuka_formularies", column: "formulary_id", name: "otsuka_pdf_access_archive_formulary_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_pdf_access_archive", "otsuka_users", column: "user_id", name: "otsuka_pdf_access_archive_user_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_plan_drug_options", "otsuka_users", column: "created_by", name: "otsuka_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "otsuka_plan_drug_options", "otsuka_users", column: "updated_by", name: "otsuka_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "otsuka_plan_drug_settings", "drug", name: "otsuka_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_plan_drug_settings", "healthplan", name: "otsuka_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_plan_drug_settings", "otsuka_users", column: "user_id", name: "otsuka_plan_drug_settings_site_user_id_fk", on_update: :cascade
  add_foreign_key "otsuka_plan_drug_settings", "state", name: "otsuka_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_plan_tier_labels", "healthplan", name: "otsuka_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_plan_tier_labels", "otsuka_tier_labels", column: "tier_label_id", name: "otsuka_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_plan_tier_labels", "tier", name: "otsuka_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_provider_rollup", "otsuka_users", column: "user_id", name: "otsuka_provider_rollup_user_id_fk", on_update: :cascade
  add_foreign_key "otsuka_provider_rollup", "provider", name: "otsuka_provider_rollup_provider_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "otsuka_tier_labels", "tier", name: "otsuka_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pbm_healthplan_pharmacy", "ffuser", column: "creatorid_fk", primary_key: "userid", name: "pbm_healthplan_pharmacy_creatorid_fk_fkey", on_update: :cascade
  add_foreign_key "pbm_healthplan_pharmacy", "ffuser", column: "modbyid_fk", primary_key: "userid", name: "pbm_healthplan_pharmacy_modbyid_fk_fkey", on_update: :cascade
  add_foreign_key "pbm_healthplan_pharmacy", "healthplan", column: "healthplanid_fk", name: "pbm_healthplan_pharmacy_healthplanid_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pbm_healthplan_pharmacy", "pbm_specialty_pharmacy", column: "pharmacyid_fk", name: "pbm_healthplan_pharmacy_pharmacyid_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pbm_specialty_pharmacy", "ffuser", column: "creatorid_fk", primary_key: "userid", name: "pbm_specialty_pharmacy_creatorid_fk_fkey", on_update: :cascade
  add_foreign_key "pbm_specialty_pharmacy", "ffuser", column: "modbyid_fk", primary_key: "userid", name: "pbm_specialty_pharmacy_modbyid_fk_fkey", on_update: :cascade
  add_foreign_key "pbm_specialty_pharmacy", "state", column: "state_fk", name: "pbm_specialty_pharmacy_state_fk_fkey", on_update: :cascade
  add_foreign_key "pbm_specialty_pharmacy_specialization", "ffuser", column: "creatorid_fk", primary_key: "userid", name: "pbm_specialty_pharmacy_specialization_creatorid_fk_fkey", on_update: :cascade
  add_foreign_key "pbm_specialty_pharmacy_specialization", "ffuser", column: "modbyid_fk", primary_key: "userid", name: "pbm_specialty_pharmacy_specialization_modbyid_fk_fkey", on_update: :cascade
  add_foreign_key "pbm_specialty_pharmacy_specialization", "pbm_specialty_pharmacy", column: "pharmacyid_fk", name: "pbm_specialty_pharmacy_specialization_pharmacyid_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_drug_plan_inclusions", "drug", column: "id", name: "pfizer_drug_plan_inclusions_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_drug_plan_inclusions", "healthplan", name: "pfizer_drug_plan_inclusions_healthplan_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_formulary_drugclass_template", "drugclass", column: "drugclass_id_fk", name: "pfizer_formulary_drugclass_template_drugclass_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_plan_administration_filter", "healthplan", column: "healthplanid_fk", name: "pfizer_plan_administration_filter_healthplanid_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_plan_tier_label", "healthplan", column: "healthplan_id_fk", name: "pfizer_plan_tier_label_healthplan_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_plan_tier_label", "pfizer_tier_label", column: "tier_label_id_fk", name: "pfizer_plan_tier_label_tier_label_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_plan_tier_label", "tier", column: "tier_id_fk", name: "pfizer_plan_tier_label_tier_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_plan_type_category", "healthplantype", column: "plantype_id_fk", name: "pfizer_plan_type_category_plantype_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_plan_type_category", "pfizer_plan_category", column: "category_id_fk", name: "pfizer_plan_type_category_category_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_provider_logos", "pfizeruser", column: "user_id", primary_key: "entityid", name: "pfizer_provider_logos_user_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "pfizer_provider_logos", "provider", name: "pfizer_provider_logos_provider_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizer_role_code_map", "pfizerrole", column: "pfizer_role_id", primary_key: "entityid", name: "pfizer_role_code_map_pfizer_role_id_fkey"
  add_foreign_key "pfizer_static_file", "drug", name: "pfizer_static_files_drug_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "pfizer_static_file", "pfizeruser", column: "create_user_id", primary_key: "entityid", name: "pfizer_static_files_create_user_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "pfizer_static_file", "pfizeruser", column: "update_user_id", primary_key: "entityid", name: "pfizer_static_files_update_user_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "pfizer_static_file", "state", name: "pfizer_static_files_state_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "pfizer_tier_label", "tier", column: "tier_id_fk", name: "pfizer_tier_label_tier_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizerdrugplanform", "pfizerformulary", column: "formularyfid", primary_key: "entityid", name: "pfizerdrugplanform_formularyfid_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pfizerformulary", "drugclass", column: "drugclassfid", name: "pfizerformulary_drugclassfid_fkey", on_update: :cascade
  add_foreign_key "pfizerformulary", "pfizer_provider_logos", column: "provider_logo_id", name: "pfizerformulary_provider_logo_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "pfizerformulary", "state", column: "statefid", name: "pfizerformulary_statefid_fkey", on_update: :cascade
  add_foreign_key "pfizermsastate", "pfizermsa", column: "msafid", name: "pfizermsastate_msafid_fkey", on_update: :cascade
  add_foreign_key "pfizermsastate", "state", column: "statefid", name: "pfizermsastate_statefid_fkey", on_update: :cascade
  add_foreign_key "pfizeruser", "pfizer_business_units", column: "pfizer_bu_id", name: "pfizeruser_pfizer_bu_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "pfizeruser", "pfizer_teams", name: "pfizeruser_pfizer_team_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "pfizeruser", "pfizerrole", column: "rolefid", primary_key: "entityid", name: "rolefid_fk"
  add_foreign_key "provideraddress", "address", column: "addressfid", name: "provideraddress_addressfid_fkey"
  add_foreign_key "provideraddress", "provider", column: "providerfid", name: "provideraddress_providerfid_fkey"
  add_foreign_key "providercomment", "comment", column: "commentfid", name: "providercomment_commentfid_fkey"
  add_foreign_key "providercomment", "provider", column: "providerfid", name: "providercomment_providerfid_fkey"
  add_foreign_key "providercontact", "contact", column: "contactfid", name: "providercontact_contactfid_fkey"
  add_foreign_key "providercontact", "provider", column: "providerfid", name: "providercontact_providerfid_fkey"
  add_foreign_key "purdue_formularies", "drugclass", column: "drug_class_id", name: "purdue_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "purdue_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "purdue_formularies_template_fk", on_update: :cascade
  add_foreign_key "purdue_formularies", "purdue_users", column: "site_user_id", name: "purdue_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "purdue_formularies", "state", name: "purdue_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "purdue_plan_drug_options", "purdue_users", column: "created_by", name: "purdue_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "purdue_plan_drug_options", "purdue_users", column: "updated_by", name: "purdue_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "purdue_plan_drug_settings", "drug", name: "purdue_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purdue_plan_drug_settings", "healthplan", name: "purdue_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purdue_plan_drug_settings", "purdue_plan_drug_options", column: "plan_drug_option_id", name: "purdue_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purdue_plan_drug_settings", "purdue_users", column: "created_by", name: "purdue_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "purdue_plan_drug_settings", "purdue_users", column: "updated_by", name: "purdue_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "purdue_plan_drug_settings", "state", name: "purdue_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purdue_plan_tier_labels", "healthplan", name: "purdue_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purdue_plan_tier_labels", "purdue_tier_labels", column: "tier_label_id", name: "purdue_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purdue_plan_tier_labels", "tier", name: "purdue_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purdue_tier_labels", "tier", name: "purdue_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purplepassalert", "drug", column: "drugfid", name: "purplepassalert_drugfid_fkey"
  add_foreign_key "purplepassalert", "healthplan", column: "healthplanfid", name: "purplepassalert_healthplanfid_fkey"
  add_foreign_key "purplepassalert", "tier", column: "tierfid", name: "purplepassalert_tierfid_fkey"
  add_foreign_key "purplepasshealthplan", "healthplan", column: "healthplanfid", name: "purplepasshealthplan_healthplanfid_fkey"
  add_foreign_key "purplepasshealthplan", "purplepass", column: "purplepassfid", name: "purplepasshealthplan_purplepassfid_fkey"
  add_foreign_key "purplepassservice", "drugclass", column: "drugclassfid", name: "purplepassservice_drugclassfid_fkey"
  add_foreign_key "purplepassservice", "healthplan", column: "healthplanfid", name: "purplepassservice_healthplanfid_fkey"
  add_foreign_key "purplepassservice", "purplepass", column: "purplepassfid", name: "purplepassservice_purplepassfid_fkey"
  add_foreign_key "purplepasssession", "purplepass", column: "purplepassfid", name: "purplepasssession_purplepassfid_fkey"
  add_foreign_key "purplepassuseralert", "drug", column: "drugfid", name: "purplepassuseralert_drugfid_fkey"
  add_foreign_key "purplepassuseralert", "drugclass", column: "drugclassfid", name: "purplepassuseralert_drugclassfid_fkey"
  add_foreign_key "purplepassuseralert", "healthplan", column: "healthplanfid", name: "purplepassuseralert_healthplanfid_fkey"
  add_foreign_key "purplepassuseralert", "purplepass", column: "purplepassfid", name: "purplepassuseralert_purplepassfid_fkey"
  add_foreign_key "purplepassuseralert", "tier", column: "tierfidnew", name: "purplepassuseralert_tierfidnew_fkey"
  add_foreign_key "purplepassuseralert", "tier", column: "tierfidold", name: "purplepassuseralert_tierfidold_fkey"
  add_foreign_key "restriction_report_drug_formulary", "healthplan", name: "restriction_report_drug_formulary_healthplan_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "restriction_report_drug_formulary", "restrictionreportdrug", column: "restriction_report_drug_id", name: "restriction_report_drug_formula_restriction_report_drug_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "roche_formularies", "drugclass", column: "drug_class_id", name: "roche_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "roche_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "roche_formularies_template_fk", on_update: :cascade
  add_foreign_key "roche_formularies", "roche_users", column: "site_user_id", name: "roche_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "roche_formularies", "state", name: "roche_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "roche_msa_names", "metrostatarea", column: "msa_id", name: "roche_msa_names_msa_id_fk", on_update: :cascade
  add_foreign_key "roche_msa_names", "roche_users", column: "user_id", name: "roche_msa_names_user_id_fk", on_update: :cascade
  add_foreign_key "roche_plan_drug_settings", "drug", name: "roche_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "roche_plan_drug_settings", "healthplan", name: "roche_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "roche_plan_drug_settings", "roche_users", column: "site_user_id", name: "roche_plan_drug_settings_site_user_id_fk", on_update: :cascade
  add_foreign_key "roche_plan_drug_settings", "state", name: "roche_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "roche_plan_tier_labels", "healthplan", name: "roche_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "roche_plan_tier_labels", "roche_tier_labels", column: "tier_label_id", name: "roche_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "roche_plan_tier_labels", "tier", name: "roche_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "roche_tier_labels", "tier", name: "roche_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_formularies", "bms_formularies", name: "sa_formularies_bms_formulary_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_formularies", "drugclass", column: "drug_class_id", name: "sa_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "sa_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "sa_formularies_template_fk", on_update: :cascade
  add_foreign_key "sa_formularies", "state", name: "sa_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "sa_formulary_approvals", "sa_formularies", column: "formulary_id", name: "sa_formulary_approvals_formulary_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_formulary_approvals", "sa_users", column: "user_id", name: "sa_formulary_approvals_user_id_fk", on_update: :cascade
  add_foreign_key "sa_formulary_exports", "bms_formularies", column: "formulary_id", name: "bms_formulary_exports_formulary_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_msa_names", "metrostatarea", column: "msa_id", name: "az_msa_names_msa_id_fk", on_update: :cascade
  add_foreign_key "sa_msa_names", "sa_users", column: "user_id", name: "az_msa_names_user_id_fk", on_update: :cascade
  add_foreign_key "sa_plan_drug_settings", "drug", name: "sa_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_plan_drug_settings", "healthplan", name: "sa_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_plan_drug_settings", "sa_users", column: "user_id", name: "sa_plan_drug_settings_site_user_id_fk", on_update: :cascade
  add_foreign_key "sa_plan_drug_settings", "state", name: "sa_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_plan_names", "healthplan", name: "az_plan_names_msa_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_plan_names", "sa_users", column: "user_id", name: "az_plan_names_user_id_fk", on_update: :cascade
  add_foreign_key "sa_plan_tier_labels", "healthplan", name: "sa_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_plan_tier_labels", "sa_tier_labels", column: "tier_label_id", name: "sa_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_plan_tier_labels", "tier", name: "sa_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sa_tier_labels", "tier", name: "sa_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "salix_formularies", "drugclass", column: "drug_class_id", name: "salix_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "salix_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "salix_formularies_template_fk", on_update: :cascade
  add_foreign_key "salix_formularies", "salix_users", column: "site_user_id", name: "salix_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "salix_formularies", "state", name: "salix_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "salix_plan_drug_options", "salix_users", column: "created_by", name: "salix_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "salix_plan_drug_options", "salix_users", column: "updated_by", name: "salix_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "salix_plan_drug_settings", "drug", name: "salix_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "salix_plan_drug_settings", "healthplan", name: "salix_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "salix_plan_drug_settings", "salix_plan_drug_options", column: "plan_drug_option_id", name: "salix_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "salix_plan_drug_settings", "salix_users", column: "created_by", name: "salix_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "salix_plan_drug_settings", "salix_users", column: "updated_by", name: "salix_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "salix_plan_drug_settings", "state", name: "salix_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "salix_plan_tier_labels", "healthplan", name: "salix_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "salix_plan_tier_labels", "salix_tier_labels", column: "tier_label_id", name: "salix_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "salix_plan_tier_labels", "tier", name: "salix_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "salix_tier_labels", "tier", name: "salix_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sepracor_formularies", "drugclass", column: "drug_class_id", name: "sepracor_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "sepracor_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "sepracor_formularies_template_fk", on_update: :cascade
  add_foreign_key "sepracor_formularies", "sepracor_users", column: "site_user_id", name: "sepracor_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "sepracor_formularies", "state", name: "sepracor_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "sepracor_plan_drug_options", "sepracor_users", column: "created_by", name: "sepracor_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "sepracor_plan_drug_options", "sepracor_users", column: "updated_by", name: "sepracor_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "sepracor_plan_drug_settings", "drug", name: "sepracor_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sepracor_plan_drug_settings", "healthplan", name: "sepracor_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sepracor_plan_drug_settings", "sepracor_plan_drug_options", column: "plan_drug_option_id", name: "sepracor_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sepracor_plan_drug_settings", "sepracor_users", column: "created_by", name: "sepracor_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "sepracor_plan_drug_settings", "sepracor_users", column: "updated_by", name: "sepracor_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "sepracor_plan_drug_settings", "state", name: "sepracor_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sepracor_plan_tier_labels", "healthplan", name: "sepracor_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sepracor_plan_tier_labels", "sepracor_tier_labels", column: "tier_label_id", name: "sepracor_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sepracor_plan_tier_labels", "tier", name: "sepracor_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sepracor_tier_labels", "tier", name: "sepracor_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shire_dma_copay_approval", "dma", name: "shire_dma_copay_approval_dma_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shire_dma_copay_approval", "drug", name: "shire_dma_copay_approval_drug_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shire_dma_names", "dma", name: "shire_dma_name_dma_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shire_dma_names", "shire_users", column: "updated_by_id", name: "shire_dma_name_updated_by_id_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "shire_formularies", "dma", name: "shire_formularies_dma_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shire_formularies", "drugclass", column: "drug_class_id", name: "shire_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "shire_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "shire_formularies_template_fk", on_update: :cascade
  add_foreign_key "shire_formularies", "shire_users", column: "site_user_id", name: "shire_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "shire_formularies", "state", name: "shire_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "shire_plan_tier_labels", "healthplan", name: "shire_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shire_plan_tier_labels", "shire_tier_labels", column: "tier_label_id", name: "shire_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shire_plan_tier_labels", "tier", name: "shire_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "shire_provider_custom", "provider", name: "shire_provider_custom_provider_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "state", "azbusinesscenter", column: "azbusinesscenterfid", primary_key: "entityid", name: "state_azbusinesscenterfid_fkey"
  add_foreign_key "state", "country", column: "countryfid", name: "state_countryfid_fkey"
  add_foreign_key "strativa_formularies", "drugclass", column: "drug_class_id", name: "strativa_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "strativa_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "strativa_formularies_template_fk", on_update: :cascade
  add_foreign_key "strativa_formularies", "state", name: "strativa_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "strativa_formularies", "strativa_users", column: "site_user_id", name: "strativa_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "strativa_plan_drug_options", "strativa_users", column: "created_by", name: "strativa_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "strativa_plan_drug_options", "strativa_users", column: "updated_by", name: "strativa_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "strativa_plan_drug_settings", "drug", name: "strativa_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "strativa_plan_drug_settings", "healthplan", name: "strativa_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "strativa_plan_drug_settings", "state", name: "strativa_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "strativa_plan_drug_settings", "strativa_plan_drug_options", column: "plan_drug_option_id", name: "strativa_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "strativa_plan_drug_settings", "strativa_users", column: "created_by", name: "strativa_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "strativa_plan_drug_settings", "strativa_users", column: "updated_by", name: "strativa_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "strativa_plan_tier_labels", "healthplan", name: "strativa_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "strativa_plan_tier_labels", "strativa_tier_labels", column: "tier_label_id", name: "strativa_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "strativa_plan_tier_labels", "tier", name: "strativa_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "strativa_tier_labels", "tier", name: "strativa_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "takeda_formularies", "drugclass", column: "drug_class_id", name: "takeda_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "takeda_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "takeda_formularies_template_fk", on_update: :cascade
  add_foreign_key "takeda_formularies", "state", name: "takeda_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "takeda_formularies", "takeda_users", column: "site_user_id", name: "takeda_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "takeda_plan_drug_options", "takeda_users", column: "created_by", name: "takeda_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "takeda_plan_drug_options", "takeda_users", column: "updated_by", name: "takeda_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "takeda_plan_drug_settings", "drug", name: "takeda_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "takeda_plan_drug_settings", "healthplan", name: "takeda_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "takeda_plan_drug_settings", "state", name: "takeda_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "takeda_plan_drug_settings", "takeda_plan_drug_options", column: "plan_drug_option_id", name: "takeda_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "takeda_plan_drug_settings", "takeda_users", column: "created_by", name: "takeda_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "takeda_plan_drug_settings", "takeda_users", column: "updated_by", name: "takeda_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "takeda_plan_tier_labels", "healthplan", name: "takeda_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "takeda_plan_tier_labels", "takeda_tier_labels", column: "tier_label_id", name: "takeda_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "takeda_plan_tier_labels", "tier", name: "takeda_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "takeda_provider_contact", "provider", column: "providerid_fk", name: "takeda_provider_contact_providerid_fk_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "takeda_provider_contact", "state", column: "state_fk", name: "takeda_provider_contact_state_fk_fkey", on_update: :cascade
  add_foreign_key "takeda_provider_contact", "takedauser", column: "creatorid_fk", primary_key: "entityid", name: "takeda_provider_contact_creatorid_fk_fkey", on_update: :cascade
  add_foreign_key "takeda_provider_contact", "takedauser", column: "modbyid_fk", primary_key: "entityid", name: "takeda_provider_contact_modbyid_fk_fkey", on_update: :cascade
  add_foreign_key "takeda_provider_contact_notes", "takeda_provider_contact", column: "contactid_fk", name: "takeda_provider_contact_notes_contactid_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "takeda_provider_contact_notes", "takedauser", column: "creatorid_fk", primary_key: "entityid", name: "takeda_provider_contact_notes_creatorid_fk_fkey", on_update: :cascade
  add_foreign_key "takeda_tier_labels", "tier", name: "takeda_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teva_formularies", "drugclass", column: "drug_class_id", name: "teva_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "teva_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "teva_formularies_template_fk", on_update: :cascade
  add_foreign_key "teva_formularies", "state", name: "teva_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "teva_plan_drug_settings", "drug", name: "teva_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teva_plan_drug_settings", "healthplan", name: "teva_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teva_plan_drug_settings", "state", name: "teva_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teva_plan_drug_settings", "teva_plan_drug_options", column: "plan_drug_option_id", name: "teva_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teva_plan_tier_labels", "healthplan", name: "teva_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teva_plan_tier_labels", "teva_tier_labels", column: "tier_label_id", name: "teva_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teva_plan_tier_labels", "tier", name: "teva_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "teva_tier_labels", "tier", name: "teva_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "tevaformulary", "drugclass", column: "drugclassfid", name: "tevaformulary_drugclassfid_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "tevaformulary", "state", column: "statefid", name: "tevaformulary_statefid_fkey", on_update: :cascade
  add_foreign_key "tevaformulary", "tevauser", column: "userfid", primary_key: "entityid", name: "tevaformulary_userfid_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "tevauser", "tevarole", column: "rolefid", primary_key: "entityid", name: "tevauser_rolefid_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "url_formularies", "drugclass", column: "drug_class_id", name: "url_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "url_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "url_formularies_template_fk", on_update: :cascade
  add_foreign_key "url_formularies", "state", name: "url_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "url_formularies", "url_users", column: "site_user_id", name: "url_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "url_plan_drug_options", "url_users", column: "created_by", name: "url_plan_drug_options_created_by_fk", on_update: :cascade
  add_foreign_key "url_plan_drug_options", "url_users", column: "updated_by", name: "url_plan_drug_options_updated_by_fk", on_update: :cascade
  add_foreign_key "url_plan_drug_settings", "drug", name: "url_plan_drug_settings_drug_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "url_plan_drug_settings", "healthplan", name: "url_plan_drug_settings_healthplan_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "url_plan_drug_settings", "state", name: "url_plan_drug_settings_state_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "url_plan_drug_settings", "url_plan_drug_options", column: "plan_drug_option_id", name: "url_plan_drug_settings_plan_drug_option_id_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "url_plan_drug_settings", "url_users", column: "created_by", name: "url_plan_drug_settings_created_by_fk", on_update: :cascade
  add_foreign_key "url_plan_drug_settings", "url_users", column: "updated_by", name: "url_plan_drug_settings_updated_by_fk", on_update: :cascade
  add_foreign_key "url_plan_tier_labels", "healthplan", name: "url_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "url_plan_tier_labels", "tier", name: "url_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "url_plan_tier_labels", "url_tier_labels", column: "tier_label_id", name: "url_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "url_tier_labels", "tier", name: "url_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wc_formularies", "drugclass", column: "drug_class_id", name: "wc_formularies_drug_class_id_fk", on_update: :cascade
  add_foreign_key "wc_formularies", "ff_publisher_template", column: "template", primary_key: "template", name: "wc_formularies_template_fk", on_update: :cascade
  add_foreign_key "wc_formularies", "metrostatarea", column: "msa_id", name: "wc_formularies_msa_id_fkey", on_update: :cascade
  add_foreign_key "wc_formularies", "state", name: "wc_formularies_state_id_fk", on_update: :cascade
  add_foreign_key "wc_formularies", "wc_users", column: "site_user_id", name: "wc_formularies_site_user_id_fk", on_update: :cascade
  add_foreign_key "wc_plan_tier_labels", "healthplan", name: "wc_plan_tier_labels_healthplan_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wc_plan_tier_labels", "tier", name: "wc_plan_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wc_plan_tier_labels", "wc_tier_labels", column: "tier_label_id", name: "wc_plan_tier_labels_tier_label_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wc_provider_custom", "provider", name: "wc_provider_custom_provider_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wc_tier_labels", "tier", name: "wc_tier_labels_tier_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wyeth_plan_tier_label", "healthplan", column: "healthplan_id_fk", name: "wyeth_plan_tier_label_healthplan_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wyeth_plan_tier_label", "tier", column: "tier_id_fk", name: "wyeth_plan_tier_label_tier_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wyeth_plan_tier_label", "wyeth_tier_label", column: "tier_label_id_fk", name: "wyeth_plan_tier_label_tier_label_id_fk_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wyeth_tier_label", "tier", column: "tier_id_fk", name: "wyeth_tier_label_tier_id_fk_fkey", on_update: :cascade, on_delete: :cascade
end
