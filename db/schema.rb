# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_11_145606) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "caption"
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "blog_posts", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.text "content"
    t.text "images"
    t.boolean "published"
    t.datetime "published_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_image"
  end

  create_table "collection_entries", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.bigint "entry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_collection_entries_on_collection_id"
    t.index ["entry_id"], name: "index_collection_entries_on_entry_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "title"
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at"
  end

  create_table "digested_read_taggings", force: :cascade do |t|
    t.bigint "digested_read_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["digested_read_id"], name: "index_digested_read_taggings_on_digested_read_id"
    t.index ["tag_id"], name: "index_digested_read_taggings_on_tag_id"
  end

  create_table "digested_reads", force: :cascade do |t|
    t.string "title"
    t.string "summary"
    t.text "content"
    t.text "excerpt"
    t.string "book_cover_image"
    t.string "affiliate_link"
    t.text "author_info"
    t.string "tags"
    t.datetime "published_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_subscribers", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmed"
  end

  create_table "entries", force: :cascade do |t|
    t.string "title"
    t.string "summary"
    t.text "content"
    t.string "entryable_type"
    t.integer "entryable_id"
    t.datetime "published_at"
    t.datetime "marked_for_promotion_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_image"
  end

  create_table "entry_taggings", force: :cascade do |t|
    t.bigint "entry_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_id"], name: "index_entry_taggings_on_entry_id"
    t.index ["tag_id"], name: "index_entry_taggings_on_tag_id"
  end

  create_table "image_uploads", force: :cascade do |t|
    t.string "title"
    t.string "website_url"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "ingredient_entries", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.float "quantity"
    t.string "unit"
    t.string "size"
    t.string "modifier"
    t.integer "ingredient_set_id"
    t.string "original_string"
    t.string "ingredient_name"
    t.boolean "quantityless"
    t.integer "position"
    t.index ["ingredient_set_id"], name: "index_ingredient_entries_on_ingredient_set_id"
  end

  create_table "ingredient_entry_ingredient_sources", force: :cascade do |t|
    t.bigint "ingredient_entry_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_entry_id"], name: "index_ingredient_entry_source"
    t.index ["ingredient_id"], name: "index_ingredient_source"
  end

  create_table "ingredient_entry_recipe_sources", force: :cascade do |t|
    t.bigint "ingredient_entry_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_entry_id"], name: "index_ingredient_entry_recipe_entry_source"
    t.index ["recipe_id"], name: "index_recipe_recipe_entry_source"
  end

  create_table "ingredient_sets", force: :cascade do |t|
    t.string "title"
    t.integer "position"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "synonyms"
    t.text "content"
    t.integer "animal_status"
    t.json "nutrition"
    t.boolean "publishable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "related_recipes_heading"
  end

  create_table "ip_addresses", force: :cascade do |t|
    t.string "ip_address"
    t.string "name"
    t.boolean "admin_access"
    t.datetime "admin_access_expires", precision: nil
  end

  create_table "method_steps", force: :cascade do |t|
    t.integer "position"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "recipe_id"
    t.index ["recipe_id"], name: "index_method_steps_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.string "total_time"
    t.text "introduction"
    t.integer "serves"
    t.integer "makes"
    t.string "makes_unit"
    t.string "recipe_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "category"
    t.string "image_url"
    t.boolean "published", default: false
    t.datetime "published_at", precision: nil
    t.datetime "marked_for_promotion_at"
    t.string "type"
    t.text "related_recipe_ids", default: [], array: true
    t.string "related_recipes_heading"
    t.boolean "has_image"
    t.json "nutrition"
    t.boolean "show_nutrition"
  end

  create_table "solid_cache_entries", force: :cascade do |t|
    t.binary "key", null: false
    t.binary "value", null: false
    t.datetime "created_at", null: false
    t.bigint "key_hash", null: false
    t.integer "byte_size", null: false
    t.index ["byte_size"], name: "index_solid_cache_entries_on_byte_size"
    t.index ["key_hash", "byte_size"], name: "index_solid_cache_entries_on_key_hash_and_byte_size"
    t.index ["key_hash"], name: "index_solid_cache_entries_on_key_hash", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_tags_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ingredient_entry_ingredient_sources", "ingredient_entries"
  add_foreign_key "ingredient_entry_ingredient_sources", "ingredients"
  add_foreign_key "ingredient_entry_recipe_sources", "ingredient_entries"
  add_foreign_key "ingredient_entry_recipe_sources", "recipes"
end
