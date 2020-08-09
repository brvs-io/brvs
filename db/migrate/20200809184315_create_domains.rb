# frozen_string_literal: true

# Creates the domains table and adds reference to links.
class CreateDomains < ActiveRecord::Migration[6.0]
  def change
    create_table :domains, id: :uuid do |t|
      t.references :owner, type: :uuid, null: false
      t.text :name, null: false
      t.datetime :verified_at
      t.timestamps

      t.index :name, unique: true
      t.index :verified_at

      t.foreign_key :users, column: :owner_id
    end

    remove_index :links, :name

    change_table :links, bulk: true do |t|
      t.references :domain, type: :uuid

      t.index %i[name domain_id], unique: true

      t.foreign_key :domains, column: :domain_id
    end
  end
end
