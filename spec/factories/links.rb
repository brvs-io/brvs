# frozen_string_literal: true

# ## Schema Information
#
# Table name: `links`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `uuid`             | `not null, primary key`
# **`archived_at`**  | `datetime`         |
# **`expires_in`**   | `integer`          |
# **`name`**         | `text`             | `not null`
# **`notes`**        | `text`             |
# **`properties`**   | `jsonb`            | `not null`
# **`tags`**         | `text`             | `default([]), not null, is an Array`
# **`target`**       | `text`             | `not null`
# **`title`**        | `text`             |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
# **`domain_id`**    | `uuid`             |
# **`owner_id`**     | `uuid`             | `not null`
#
# ### Indexes
#
# * `index_links_on_archived_at`:
#     * **`archived_at`**
# * `index_links_on_domain_id`:
#     * **`domain_id`**
# * `index_links_on_name_and_domain_id` (_unique_):
#     * **`name`**
#     * **`domain_id`**
# * `index_links_on_owner_id`:
#     * **`owner_id`**
# * `index_links_on_properties` (_using_ gin):
#     * **`properties`**
# * `index_links_on_tags` (_using_ gin):
#     * **`tags`**
# * `index_links_on_target`:
#     * **`target`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`domain_id => domains.id`**
# * `fk_rails_...`:
#     * **`owner_id => users.id`**
#
FactoryBot.define do
  factory :link do
    owner factory: :user
    target { Faker::Internet.url }

    trait :with_domain do
      domain
      owner { domain.owner }
    end

    trait :named do
      name { Faker::Company.bs.parameterize }
    end
  end
end
