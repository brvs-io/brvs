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
FactoryBot.define do
  factory :domain do
    owner factory: :user
    name { Faker::Internet.unique.domain_name }
    verified_at { Time.zone.now }

    trait :unverified do
      verified_at { nil }
    end
  end
end
