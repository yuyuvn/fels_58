# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: "Clicia Scarlet",
  email: "example@framgia.com",
  password: "123456",
  password_confirmation: "123456")

FFaker::Locale.language "en-US"

3.times do |_|
  category = Category.create!(name: FFaker::Lorem.word,
    description: FFaker::Lorem.sentence(3))
  100.times do |_|
    word = category.words.create! content: FFaker::Lorem.word
    word.answers.create!(content: FFaker::Lorem.word,
      is_correct: true)
    3.times do |_|
      word.answers.create!(content: FFaker::Lorem.word,
        is_correct: false)
    end
  end
end