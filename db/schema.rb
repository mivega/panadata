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

ActiveRecord::Schema.define(version: 20140703143027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"
  enable_extension "unaccent"

  create_table "asociaciones", id: false, force: true do |t|
    t.integer "persona_id",             null: false
    t.integer "sociedad_id",            null: false
    t.string  "rol",         limit: 20, null: false
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compras", id: false, force: true do |t|
    t.string   "url",               limit: 200
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

  add_index "compras", ["acto"], name: "compras_acto_key", unique: true, using: :btree
  add_index "compras", ["tsv_description"], name: "compras_description", using: :gin
  add_index "compras", ["url"], name: "compras_url_key", unique: true, using: :btree

  create_table "documentos", id: false, force: true do |t|
    t.string   "control",     limit: 100,                          null: false
    t.string   "institucion", limit: 100
    t.string   "documento",   limit: 100
    t.string   "numero",      limit: 100
    t.string   "favor",       limit: 100
    t.string   "estado",      limit: 100
    t.decimal  "monto",                   precision: 15, scale: 2
    t.text     "html"
    t.datetime "fecha"
    t.date     "created_at"
    t.date     "updated_at"
    t.tsvector "tsv_nombre"
  end

  add_index "documentos", ["tsv_nombre"], name: "documentos_nombre", using: :gin

  create_table "historiales", id: false, force: true do |t|
    t.integer "id",                         null: false
    t.integer "marca_id"
    t.integer "resuelto_id"
    t.string  "tramite",        limit: nil
    t.date    "fecha"
    t.string  "estado",         limit: nil
    t.date    "fecha_resuelto"
    t.string  "edicto",         limit: nil
    t.string  "examinador",     limit: nil
  end

  create_table "marca_historiales", id: false, force: true do |t|
    t.integer "historia_id", null: false
    t.integer "marca_id",    null: false
  end

  create_table "marca_productos", id: false, force: true do |t|
    t.integer "producto_id", null: false
    t.integer "marca_id",    null: false
  end

  create_table "marca_titulares", id: false, force: true do |t|
    t.integer "titular_id", null: false
    t.integer "marca_id",   null: false
  end

  create_table "marcas", id: false, force: true do |t|
    t.integer  "id",                                                                                  null: false
    t.string   "nombre",             limit: nil
    t.integer  "registro",           limit: 8,   default: "nextval('marcas_registro_seq'::regclass)", null: false
    t.integer  "secuencia"
    t.integer  "clase"
    t.string   "estado",             limit: nil
    t.string   "signo",              limit: nil
    t.string   "actividad",          limit: nil
    t.string   "abogado",            limit: nil
    t.integer  "tomo"
    t.integer  "folio"
    t.integer  "asiento"
    t.integer  "resuelto",           limit: 8
    t.integer  "boletin"
    t.integer  "plazo_pagado"
    t.date     "fecha_solicitud"
    t.date     "fecha_registro"
    t.date     "fecha_vencimiento"
    t.date     "fecha_renovacion"
    t.date     "fecha_resuelto"
    t.text     "capital_text"
    t.text     "representante_text"
    t.tsvector "tsv_nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "solicitud",          limit: nil
    t.text     "html"
  end

  add_index "marcas", ["id"], name: "marcas_id_key", unique: true, using: :btree
  add_index "marcas", ["tsv_nombre"], name: "marcas_nombre", using: :gin

  create_table "menciones", id: false, force: true do |t|
    t.integer "id",       null: false
    t.integer "marca_id"
    t.text    "nombre"
  end

  create_table "personas", id: false, force: true do |t|
    t.integer  "id",                     null: false
    t.string   "nombre",     limit: 100
    t.tsvector "tsv_nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personas", ["nombre"], name: "personas_nombre_key", unique: true, using: :btree
  add_index "personas", ["tsv_nombre"], name: "personas_nombre", using: :gin

  create_table "prioridades", id: false, force: true do |t|
    t.integer "id",       null: false
    t.integer "marca_id"
    t.text    "nombre"
  end

  create_table "productos", id: false, force: true do |t|
    t.integer "id",       null: false
    t.integer "marca_id"
    t.text    "nombre"
  end

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
    t.integer  "id"
    t.string   "nombre",             limit: 200
    t.integer  "ficha",                          null: false
    t.float    "capital"
    t.string   "moneda",             limit: 50
    t.string   "agente",             limit: 200
    t.string   "notaria",            limit: 50
    t.date     "fecha_registro"
    t.text     "capital_text"
    t.text     "representante_text"
    t.string   "status",             limit: 35
    t.string   "duracion",           limit: 15
    t.string   "provincia",          limit: 25
    t.boolean  "visited"
    t.tsvector "tsv_nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "html"
  end

  add_index "sociedades", ["ficha"], name: "sociedades_ficha_key", unique: true, using: :btree
  add_index "sociedades", ["tsv_nombre"], name: "sociedades_nombre", using: :gin

  create_table "titulares", id: false, force: true do |t|
    t.integer  "id",                     null: false
    t.string   "nombre",     limit: nil, null: false
    t.text     "domicilio"
    t.string   "pais",       limit: nil
    t.string   "estado",     limit: nil
    t.tsvector "tsv_nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "titulares", ["id"], name: "titulares_id_key", unique: true, using: :btree
  add_index "titulares", ["tsv_nombre"], name: "titulares_nombre", using: :gin

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
