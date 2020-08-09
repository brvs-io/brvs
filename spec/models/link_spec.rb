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

  describe 'validating domain belongs to owner' do
    let(:user) { FactoryBot.create(:user) }
    let(:link) { FactoryBot.build(:link, owner: user, domain: domain) }

    before { link.validate }

    context 'when domain owner and link owner are the same' do
      let(:domain) { FactoryBot.create(:domain, owner: user) }

      it 'is valid' do
        expect(link).to be_valid
      end
    end

    context 'when domain owner and link owner are not the same' do
      before { link.validate }

      let(:domain) { FactoryBot.create(:domain) }

      it 'is not valid' do
        expect(link).not_to be_valid
      end

      it 'has an error message' do
        expect(link.errors.details[:domain]).to include({ error: :must_belong_to_owner })
      end
    end
  end
end
