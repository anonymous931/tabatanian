# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  menu_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_menu_id  (menu_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  menu_id  (menu_id => menus.id)
#  user_id  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :menu

  validates :body, presence: true, length: { maximum: 200 }
end
