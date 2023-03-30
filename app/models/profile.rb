# == Schema Information
#
# Table name: profiles
#
#  id            :integer          not null, primary key
#  deadline      :date
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
class Profile < ApplicationRecord
  belongs_to :user
end
