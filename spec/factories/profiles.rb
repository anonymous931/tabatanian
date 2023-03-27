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
FactoryBot.define do
  factory :profile do
    user { nil }
    introduction { "MyText" }
    weight { 1.5 }
    fat { 1.5 }
    target_weight { 1.5 }
    target_fat { 1.5 }
    deadline { "2023-03-27 13:24:54" }
  end
end
