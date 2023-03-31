# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
# Foreign Keys
#
#  followed_id  (followed_id => users.id)
#  follower_id  (follower_id => users.id)
#
require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'バリデーションの確認' do
    context '入力値が正常' do
      it '正常に登録される' do
        relationship = build(:relationship)
        expect(relationship).to be_valid
        expect(relationship.errors).to be_empty
      end
    end

    context 'follower_idがnil' do
      it 'エラーになる' do
        relationship = build(:relationship, follower_id: "")
        expect(relationship).to be_invalid
        expect(relationship.errors).not_to be_empty
      end
    end

    context 'followed_idがnil' do
      it 'エラーになる' do
        relationship = build(:relationship, followed_id: "")
        expect(relationship).to be_invalid
        expect(relationship.errors).not_to be_empty
      end
    end

    context 'follower_idとfollowed_idが同じ値' do
      it 'エラーになる' do
        relationship = build(:relationship, follower_id: 2)
        expect(relationship).to be_invalid
        expect(relationship.errors).not_to be_empty
      end
    end
  end
end
