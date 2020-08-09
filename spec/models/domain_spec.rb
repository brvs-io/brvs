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
require 'rails_helper'

# RSpec.describe Domain, type: :model do
# end
