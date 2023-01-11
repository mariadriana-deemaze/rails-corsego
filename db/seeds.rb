psw = '12345678'

User.create!(email: 'mariaadriana15@gmail.com', password: psw, password_confirmation: psw)

5.times do |index|
  User.create!([{
    email: Faker::Internet.safe_email(name: "random_email#{index}"),
    password: psw,
    password_confirmation: psw
  }])
end

30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    description: Faker::TvShows::GameOfThrones.quote,
    short_description: Faker::Quote.famous_last_words,
    language: Faker::ProgrammingLanguage.name,
    level: ["Beginner", "Intermedite", "Advanced"].sample,
    price: Faker::Number.between(from: 10, to:200),
    user_id: User.all.ids.sample
  }])
end
