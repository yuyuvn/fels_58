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
  password_confirmation: "123456",
  is_admin: true

FFaker::Locale.language "en-US"

3.times do |_|
  category = Category.new name: FFaker::Lorem.word,
    description: FFaker::Lorem.sentence(3)
  100.times do |_|
    word = category.words.build content: FFaker::Lorem.word
    word.answers.build content: FFaker::Lorem.word,
      is_correct: true
    3.times do |_|
      word.answers.build content: FFaker::Lorem.word,
        is_correct: false
    end
  end
  category.save!
end

20.times do |i|
  target = User.create! name: FFaker::Name.name,
    email: FFaker::Internet.email,
    password: "123456",
    password_confirmation: "123456"
  user.follow target
  user.unfollow target if i.odd?
end

target = user.following.first
4.times do |i|
  learner = i > 2 ? target : user
  category = Category.order("RAND()").first
  lesson = learner.lessons.create! category_id: category.id
  lesson.results.each do |r|
    r.answer = r.word.answers.order("RAND()").first
    r.save!
  end
  lesson.save!
end
