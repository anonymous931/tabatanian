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
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_menus, through: :favorites, source: :menu

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: 'follower'
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy, inverse_of: 'followed'
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

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

  # フォローする
  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end

  # フォローを外す
  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end

  # すでにフォローしているのか確認
  def following?(user)
    followings.include?(user)
  end
end
