# frozen_string_literal: true

# Adds IndieAuth-related columns to the users table.
class AddIndieAuthProfileUrlToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :indieauth_profile_url, :text
    add_column :users, :indieauth_verified_at, :datetime
    add_index :users, :indieauth_profile_url, unique: true
  end
end
