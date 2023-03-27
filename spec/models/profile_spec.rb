# == Schema Information
#
# Table name: profiles
#
#  id            :integer          not null, primary key
#  deadline      :datetime
#  fat           :float
#  introduction  :text
#  target_fat    :float
#  target_weight :float
#  weight        :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
