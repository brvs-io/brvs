# frozen_string_literal: true

# Creates the users table.
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.text :name, null: false, default: ''
      t.text :email, null: false, default: ''
      t.text :encrypted_password, null: false, default: ''
      t.text :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.text :unconfirmed_email
      t.integer :failed_attempts, default: 0, null: false
      t.text :unlock_token
      t.datetime :locked_at
      t.boolean :admin, null: false, default: false
      t.timestamps null: false

      t.index :email, unique: true
      t.index :reset_password_token, unique: true
      t.index :confirmation_token, unique: true
      t.index :unlock_token, unique: true
      t.index :admin
    end
  end
end
