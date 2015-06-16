# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create! name: "Clicia Scarlet",
  email: "example@framgia.com",
  password: "123456",
  password_confirmation: "123456"

FFaker::Locale.language "en-US"

3.times do |_|
  category = Category.create! name: FFaker::Lorem.word,
    description: FFaker::Lorem.sentence(3)
  100.times do |_|
    word = category.words.create! content: FFaker::Lorem.word
    word.answers.create! content: FFaker::Lorem.word,
      is_correct: true
    3.times do |_|
      word.answers.create! content: FFaker::Lorem.word,
        is_correct: false
    end
  end
end

2.times do |_|  
  category = Category.first
  lesson = user.lessons.create! category_id: category.id,
    correct_number: 0
  words = category.words.take 20  
  words.each do |word|
    answer = word.answers.order("RAND()").first
    result = lesson.results.create! answer_id: answer.id, word_id: word.id
    lesson.correct_number += 1 if answer.is_correct?
  end
  lesson.save!
  user.activities.create! target_id: lesson.id,
    state: Settings.activity_state.learned
end

3.times do |_|
  target = User.create! name: FFaker::Name.name,
    email: FFaker::Internet.email,
    password: "123456",
    password_confirmation: "123456"
end

user.activities.create! target_id: 2,
  state: Settings.activity_state.follow
user.activities.create! target_id: 3,
  state: Settings.activity_state.unfollow