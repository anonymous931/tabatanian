# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  avatar           :string
#  crypted_password :string
#  email            :string           not null
#  name             :string           not null
#  role             :integer          default("general"), not null
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_many :menus,   dependent: :destroy
  has_one  :profile, dependent: :destroy

  accepts_nested_attributes_for :profile, allow_destroy: true

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 30 }

  enum role: { general: 0, admin: 1 }

  def self.ransackable_attributes(_auth_object = nil)
    %w(name)
  end
end
