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
require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'バリデーションの確認' do
    it '正常に登録される' do
      profile = build(:profile)
      expect(profile).to be_valid
      expect(profile.errors).to be_empty
    end
  end
end
