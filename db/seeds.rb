User.create!(email: 'maria_adriana@gmail.com', password: 'wazzzup', password_confirmation:'wazzzup')

5.times do 
  User.create!([{
    email: Faker::Internet.safe_email,
    password: '123456',
    password_confirmation: '123456'
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
