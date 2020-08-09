# frozen_string_literal: true

# Creates tables for Doorkeeper.
class CreateDoorkeeperTables < ActiveRecord::Migration[6.0]
  def change
    create_table :oauth_applications, id: :uuid do |t|
      t.references :owner, type: :uuid, null: false, index: false, polymorphic: true
      t.text :name, null: false
      t.text :uid, null: false
      t.text :secret, null: false
      t.text :redirect_uri
      t.text :scopes, null: false, default: ''
      t.boolean :confidential, null: false, default: true
      t.timestamps null: false

      t.index %i[owner_id owner_type], name: :index_oauth_applications_on_owner
      t.index :uid, unique: true

      t.foreign_key :users, column: :owner_id
    end

    create_table :oauth_access_grants, id: :uuid do |t|
      t.references :resource_owner, type: :uuid, null: false, index: false, polymorphic: true
      t.references :application, type: :uuid, null: false
      t.text :token, null: false
      t.integer :expires_in, null: false
      t.text :redirect_uri, null: false
      t.datetime :created_at, null: false
      t.datetime :revoked_at
      t.text :scopes, null: false, default: ''
      t.text :code_challenge
      t.text :code_challenge_method

      t.index %i[resource_owner_id resource_owner_type], name: :index_oauth_access_grants_on_resource_owner
      t.index :token, unique: true

      t.foreign_key :users, column: :resource_owner_id
      t.foreign_key :oauth_applications, column: :application_id
    end

    create_table :oauth_access_tokens, id: :uuid do |t|
      t.references :resource_owner, type: :uuid, null: false, index: false, polymorphic: true
      t.references :application, type: :uuid, null: false
      t.text :token, null: false
      t.text :refresh_token
      t.integer :expires_in
      t.datetime :revoked_at
      t.datetime :created_at, null: false
      t.text :scopes
      t.text :previous_refresh_token, null: false, default: ''

      t.index %i[resource_owner_id resource_owner_type], name: :index_oauth_access_tokens_on_resource_owner
      t.index :token, unique: true
      t.index :refresh_token, unique: true

      t.foreign_key :oauth_applications, column: :application_id
      t.foreign_key :users, column: :resource_owner_id
    end
  end
end
