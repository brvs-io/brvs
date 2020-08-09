# frozen_string_literal: true

# ## Schema Information
#
# Table name: `domains`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `uuid`             | `not null, primary key`
# **`name`**         | `text`             | `not null`
# **`verified_at`**  | `datetime`         |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
# **`owner_id`**     | `uuid`             | `not null`
#
# ### Indexes
#
# * `index_domains_on_name` (_unique_):
#     * **`name`**
# * `index_domains_on_owner_id`:
#     * **`owner_id`**
# * `index_domains_on_verified_at`:
#     * **`verified_at`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`owner_id => users.id`**
#
class Domain < ApplicationRecord
  HOSTNAME_REGEX = /\A[a-z0-9]+([\-.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/.freeze

  belongs_to :owner, class_name: 'User', inverse_of: :domains

  has_many :links, inverse_of: :domain, dependent: :destroy

  validates :name, format: { with: HOSTNAME_REGEX }, length: { maximum: 255 }, uniqueness: { case_sensitive: true }
end
