# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  menu_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_favorites_on_menu_id              (menu_id)
#  index_favorites_on_user_id              (user_id)
#  index_favorites_on_user_id_and_menu_id  (user_id,menu_id) UNIQUE
#
# Foreign Keys
#
#  menu_id  (menu_id => menus.id)
#  user_id  (user_id => users.id)
#
class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :menu

  validates :user, presence: true, uniqueness: { scope: :menu_id }
  validates :menu, presence: true
end
