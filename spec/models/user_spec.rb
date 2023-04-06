# == Schema Information
#
# Table name: users
#
#  id                                  :integer          not null, primary key
#  access_count_to_reset_password_page :integer          default(0)
#  avatar                              :string
#  crypted_password                    :string
#  email                               :string           not null
#  name                                :string           not null
#  reset_password_email_sent_at        :datetime
#  reset_password_token                :string
#  reset_password_token_expires_at     :datetime
#  role                                :integer          default("general"), not null
#  salt                                :string
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションの確認' do
    it '正常に登録される' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it '名前が記載されていない場合、エラーが出る' do
      user_without_name = build(:user, name: "")
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to eq ["を入力してください"]
    end

    it '名前が30文字を超える場合、エラーが出る' do
      user_without_name = build(:user, name: "1234567890123456789012345678901")
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to eq ["は30文字以内で入力してください"]
    end

    it 'メールアドレスが記載されていない場合、エラーが出る' do
      user_without_email = build(:user, email: "")
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors[:email]).to eq ["を入力してください"]
    end

    it '同じメールアドレスが存在する場合、エラーが出る' do
      user = create(:user)
      user_with_duplicated_email = build(:user, email: user.email)
      expect(user_with_duplicated_email).to be_invalid
      expect(user_with_duplicated_email.errors[:email]).to eq ["はすでに存在します"]
    end

    it '別のメールアドレスは、正常に登録される' do
      create(:user)
      user_with_another_email = build(:user, email: 'another_email')
      expect(user_with_another_email).to be_valid
      expect(user_with_another_email.errors).to be_empty
    end

    it 'パスワードが3文字未満の場合、エラーが出る' do
      user_without_password = build(:user, password: "a")
      expect(user_without_password).to be_invalid
      expect(user_without_password.errors[:password]).to eq ["は3文字以上で入力してください"]
    end

    it 'パスワード確認が記載されていない場合、エラーが出る' do
      user_without_password_confirmation = build(:user, password_confirmation: "")
      expect(user_without_password_confirmation).to be_invalid
      expect(user_without_password_confirmation.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません", "を入力してください"]
    end

    it 'パスワード確認がパスワードと異なる場合、エラーが出る' do
      user_without_password_confirmation = build(:user, password_confirmation: "hogehoge")
      expect(user_without_password_confirmation).to be_invalid
      expect(user_without_password_confirmation.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません"]
    end
  end
end
