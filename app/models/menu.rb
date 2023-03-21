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
  belongs_to :user
end
