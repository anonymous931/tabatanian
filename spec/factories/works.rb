# == Schema Information
#
# Table name: works
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  menu_id    :integer          not null
#
# Indexes
#
#  index_works_on_menu_id  (menu_id)
#
# Foreign Keys
#
#  menu_id  (menu_id => menus.id)
#
FactoryBot.define do
  factory :work do
    menu { nil }
    title { "MyString" }
    content { "MyText" }
  end
end
