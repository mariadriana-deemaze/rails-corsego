User.create!(email: 'maria_adriana@gmail.com', password: 'wazzzup', password_confirmation:'wazzzup')


30.times do
    Course.create!([{
      title: Faker::Educator.course_name,
      description: Faker::TvShows::GameOfThrones.quote,
      user_id: User.first.id
    }])
end