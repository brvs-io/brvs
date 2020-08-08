# frozen_string_literal: true

# Creates the links table.
class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links, id: :uuid do |t|
      t.references :owner, type: :uuid, null: false
      t.text :name, null: false
      t.text :target, null: false
      t.text :title
      t.text :tags, null: false, array: true, default: []
      t.text :notes
      t.jsonb :properties, null: false, default: {}
      t.integer :expires_in
      t.datetime :archived_at
      t.timestamps null: false

      t.index :name, unique: true
      t.index :archived_at
      t.index :properties, using: :gin
      t.index :tags, using: :gin
      t.index :target

      t.foreign_key :users, column: :owner_id
    end
  end
end
