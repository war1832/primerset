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

ActiveRecord::Schema.define(version: 20170308175749) do

  create_table "canchas", force: :cascade do |t|
    t.string   "descripcion",   limit: 255
    t.integer  "TipoCancha_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "canchas", ["TipoCancha_id"], name: "index_canchas_on_TipoCancha_id", using: :btree

  create_table "clientes", force: :cascade do |t|
    t.string   "nombre",          limit: 255
    t.string   "apellido",        limit: 255
    t.string   "direccion",       limit: 255
    t.string   "telefono",        limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "tipo_cliente_id", limit: 4
    t.string   "email",           limit: 255
  end

  add_index "clientes", ["tipo_cliente_id"], name: "index_clientes_on_tipo_cliente_id", using: :btree

  create_table "reservas", force: :cascade do |t|
    t.integer  "cliente_id",   limit: 4
    t.integer  "cancha_id",    limit: 4
    t.datetime "fecha_inicio"
    t.datetime "fecha_fin"
    t.datetime "fecha_baja"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "reservas", ["cancha_id"], name: "index_reservas_on_cancha_id", using: :btree
  add_index "reservas", ["cliente_id"], name: "index_reservas_on_cliente_id", using: :btree

  create_table "tipo_canchas", force: :cascade do |t|
    t.string   "descripcion", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "tipo_clientes", force: :cascade do |t|
    t.string   "descripcion", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "turnos_fijos", force: :cascade do |t|
    t.integer  "cliente_id",  limit: 4
    t.integer  "cancha_id",   limit: 4
    t.datetime "hora_inicio"
    t.datetime "hora_fin"
    t.integer  "dia_semana",  limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.datetime "fecha_baja"
  end

  add_index "turnos_fijos", ["cancha_id"], name: "index_turnos_fijos_on_cancha_id", using: :btree
  add_index "turnos_fijos", ["cliente_id"], name: "index_turnos_fijos_on_cliente_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "admin",                              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "reservas", "canchas"
  add_foreign_key "reservas", "clientes"
  add_foreign_key "turnos_fijos", "canchas"
  add_foreign_key "turnos_fijos", "clientes"
end
