User.create!(email: 'maria_adriana@gmail.com', password: 'wazzzup', password_confirmation:'wazzzup')


30.times do
    Course.create!([{
      title: Faker::Educator.course_name,
      description: Faker::TvShows::GameOfThrones.quote,
      short_description: Faker::Quote.famous_last_words,
      language: Faker::ProgrammingLanguage.name,
      level: 'Beginner',
      price: Faker::Number.between(from: 10, to:200),
      user_id: User.first.id
    }])
end