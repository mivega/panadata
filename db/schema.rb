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

ActiveRecord::Schema.define(version: 20131104231250) do

  create_table "asociaciones", id: false, force: true do |t|
    t.integer "persona_id",             null: false
    t.integer "sociedad_id",            null: false
    t.string  "rol",         limit: 20, null: false
  end

  add_index "asociaciones", ["sociedad_id"], name: "asociacion_sociedad_idx", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compras", id: false, force: true do |t|
    t.integer  "id"
    t.string   "url",               limit: 200,                          null: false
    t.text     "html"
    t.boolean  "visited"
    t.boolean  "parsed"
    t.integer  "category_id"
    t.string   "compra_type",       limit: 100
    t.string   "entidad",           limit: 200
    t.string   "dependencia",       limit: 200
    t.string   "nombre_contacto",   limit: 40
    t.string   "telefono_contacto", limit: 15
    t.string   "objeto",            limit: 200
    t.string   "modalidad",         limit: 200
    t.string   "correo_contacto",   limit: 200
    t.string   "unidad",            limit: 200
    t.string   "provincia",         limit: 50
    t.decimal  "precio",                        precision: 15, scale: 2
    t.decimal  "precio_cd",                     precision: 15, scale: 2
    t.string   "proponente",        limit: 200
    t.text     "description"
    t.string   "acto",              limit: 200
    t.datetime "fecha"
    t.date     "created_at"
    t.date     "updated_at"
    t.tsvector "tsv_description"
  end

  add_index "compras", ["tsv_description"], name: "compras_description", using: :gin

  create_table "corporations", force: true do |t|
    t.string   "nombre"
    t.integer  "ficha"
    t.string   "representante_text"
    t.string   "capital_text"
    t.string   "capital"
    t.decimal  "moneda"
    t.string   "agente"
    t.string   "notaria"
    t.date     "fecha_registro"
    t.string   "status"
    t.string   "duracion"
    t.string   "provincia"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personas", id: false, force: true do |t|
    t.integer  "id",                     null: false
    t.string   "nombre",     limit: 100
    t.tsvector "tsv_nombre"
  end

  add_index "personas", ["nombre"], name: "nombre_idx", unique: true, using: :btree
  add_index "personas", ["tsv_nombre"], name: "personas_nombre", using: :gin

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sociedades", id: false, force: true do |t|
    t.integer  "id",                             null: false
    t.string   "nombre",             limit: 200
    t.integer  "ficha"
    t.float    "capital"
    t.string   "moneda",             limit: 50
    t.string   "notaria",            limit: 50
    t.date     "fecha_registro"
    t.text     "capital_text"
    t.text     "representante_text"
    t.string   "status",             limit: 35
    t.string   "duracion",           limit: 15
    t.string   "provincia",          limit: 25
    t.boolean  "visited"
    t.string   "agente",             limit: 200
    t.tsvector "tsv_nombre"
  end

  add_index "sociedades", ["ficha"], name: "sociedad_ficha_idx", unique: true, using: :btree
  add_index "sociedades", ["tsv_nombre"], name: "sociedades_nombre", using: :gin

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
