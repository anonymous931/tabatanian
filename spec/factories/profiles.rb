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
FactoryBot.define do
  factory :profile do
    association :user
    introduction { "MyText" }
    weight { 58.5 }
    fat { 17.5 }
    target_weight { 55.0 }
    target_fat { 15.0 }
    deadline { "002023-03-27" }
  end
end
