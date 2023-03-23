# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  content    :text
#  thumbnail  :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_menus_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Menu < ApplicationRecord
  mount_uploader :thumbnail, ThumbnailUploader
  belongs_to :user

  def self.ransackable_attributes(_auth_object = nil)
    %w(title content)
  end

  def self.ransackable_associations(_auth_object = nil)
    %w(user)
  end
end
