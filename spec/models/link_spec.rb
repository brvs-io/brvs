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
require 'rails_helper'

RSpec.describe Link, type: :model do
  it 'sets name to a random short ID if none is specified' do
    link = FactoryBot.create(:link, name: nil)
    expect(link.name).not_to be_nil
  end

  it 'converts tag names to tags on create' do
    link = FactoryBot.create(:link, tag_names: 'one, two, three')
    expect(link.tags).to eq(%w[one two three])
  end

  it 'converts tag names to tags on update' do
    link = FactoryBot.create(:link, tags: %w[one two three])
    expect { link.update(tag_names: 'four, five, six') }.to change(link, :tags).to eq(%w[four five six])
  end

  it 'returns tags as comma-separated tag names' do
    link = FactoryBot.create(:link, tags: %w[one two three])
    expect(link.tag_names).to eq('one, two, three')
  end
end
