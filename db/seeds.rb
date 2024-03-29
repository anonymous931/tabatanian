# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '12345678',
    password_confirmation: '12345678'
  )
end

20.times do |index|
  Menu.create(
    user: User.offset(rand(User.count)).first,
    title: "タイトル#{index}",
    content: "本文#{index}"
  )
end

100.times do |index|
  Work.create(
    menu: Menu.offset(rand(Menu.count)).first,
    title: "ワーク#{index}",
    content: Faker::Address.full_address
  )
end