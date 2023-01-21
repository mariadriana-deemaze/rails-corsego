psw = '12345678'

# gem `public_activity`: temporarly disable not to register any activity
PublicActivity.enabled = false

admin = User.create!( email: 'mariaadriana15@gmail.com', 
  password: psw, 
  password_confirmation: psw )
  
  admin.skip_confirmation!
  admin.add_role :admin
  admin.save!
  
  5.times do |index|
    user = User.create!( email: Faker::Internet.safe_email(name: "random_email#{index}"),
                         password: psw,
                         password_confirmation: psw)
      
    user.skip_confirmation!

      # Exception to create teacher role
      if index === 0 
        user.add_role :teacher
      end    
                       
    end
    
    30.times do
      Course.create!([{
        title: Faker::Educator.course_name,
        description: Faker::TvShows::GameOfThrones.quote,
        short_description: Faker::Quote.famous_last_words,
        language: Faker::ProgrammingLanguage.name,
        level: ["Beginner", "Intermediate", "Advanced"].sample,
        price: Faker::Number.between(from: 0, to:200),
        user_id: User.all.ids.sample,
        published: true,
        approved: true
        }])
      end
      
PublicActivity.enabled = true
