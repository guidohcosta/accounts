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

ActiveRecord::Schema.define(version: 2018_11_15_112622) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "balance"
    t.string "name"
    t.date "creation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id"
    t.string "person_type"
    t.string "accountable_type"
    t.bigint "accountable_id"
    t.index ["accountable_type", "accountable_id"], name: "index_accounts_on_accountable_type_and_accountable_id"
    t.index ["person_type", "person_id"], name: "index_accounts_on_person_type_and_person_id"
  end

  create_table "branches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "parent_id"
    t.string "parent_type"
    t.bigint "head_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["head_id"], name: "index_branches_on_head_id"
  end

  create_table "contributions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.bigint "head_id"
    t.integer "amount"
    t.boolean "reversed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_contributions_on_code", unique: true
    t.index ["head_id"], name: "index_contributions_on_head_id"
  end

  create_table "heads", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "legal_people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cnpj"
    t.string "corporate_name"
    t.string "trading_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "natural_people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cpf"
    t.string "fullname"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "from_type"
    t.bigint "from_id"
    t.integer "to"
    t.integer "amount"
    t.boolean "reversed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_type", "from_id"], name: "index_transfers_on_from_type_and_from_id"
  end

  add_foreign_key "branches", "heads"
  add_foreign_key "contributions", "heads"
end
