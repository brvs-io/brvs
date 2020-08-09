# frozen_string_literal: true

# A user account.
#
# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `uuid`             | `not null, primary key`
# **`admin`**                   | `boolean`          | `default(FALSE), not null`
# **`confirmation_sent_at`**    | `datetime`         |
# **`confirmation_token`**      | `string`           |
# **`confirmed_at`**            | `datetime`         |
# **`current_sign_in_at`**      | `datetime`         |
# **`current_sign_in_ip`**      | `inet`             |
# **`email`**                   | `text`             | `default(""), not null`
# **`encrypted_password`**      | `text`             | `default(""), not null`
# **`failed_attempts`**         | `integer`          | `default(0), not null`
# **`last_sign_in_at`**         | `datetime`         |
# **`last_sign_in_ip`**         | `inet`             |
# **`locked_at`**               | `datetime`         |
# **`name`**                    | `text`             | `default(""), not null`
# **`remember_created_at`**     | `datetime`         |
# **`reset_password_sent_at`**  | `datetime`         |
# **`reset_password_token`**    | `text`             |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`unconfirmed_email`**       | `text`             |
# **`unlock_token`**            | `text`             |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_admin`:
#     * **`admin`**
# * `index_users_on_confirmation_token` (_unique_):
#     * **`confirmation_token`**
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
# * `index_users_on_unlock_token` (_unique_):
#     * **`unlock_token`**
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :lockable,
         :confirmable, :recoverable, :rememberable, :validatable

  has_many :domains, foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy

  has_many :links, foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy

  has_many :access_tokens, as: :resource_owner, class_name: 'Doorkeeper::AccessToken',
                           inverse_of: :resource_owner, dependent: :destroy

  has_many :developer_applications, as: :owner, class_name: 'Doorkeeper::Application',
                                    inverse_of: :owner, dependent: :destroy

  validates :name, presence: true
end
