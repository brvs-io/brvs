# frozen_string_literal: true

# A link that can be redirected to.
#
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
# **`owner_id`**     | `uuid`             | `not null`
#
# ### Indexes
#
# * `index_links_on_archived_at`:
#     * **`archived_at`**
# * `index_links_on_name` (_unique_):
#     * **`name`**
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
#     * **`owner_id => users.id`**
#
class Link < ApplicationRecord
  belongs_to :owner, class_name: 'User', inverse_of: :links

  validates :target, url: true

  validates :name, uniqueness: { case_sensitive: true }

  before_validation :generate_name, on: :create

  def tag_names
    tags.join(', ')
  end

  def tag_names=(val)
    self.tags = val.strip.gsub(/\s+/, ' ').split(',').map(&:strip)
  end

  private

  def generate_name
    self.name = ShortNameGenerator.new.call if name.blank?
  end
end
