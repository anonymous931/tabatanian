# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_board_id  (board_id)
#  index_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  board_id  (board_id => boards.id)
#  user_id   (user_id => users.id)
#
FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user { nil }
    board { nil }
  end
end
