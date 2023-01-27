psw = 'password'

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


teacher = User.second
student = User.third
    
5.times do
  paid_course = Course.create(
      title: Faker::Educator.course_name,
      description: Faker::TvShows::GameOfThrones.quote,
      short_description: Faker::Quote.famous_last_words,
      language: Faker::ProgrammingLanguage.name,
      level: ["Beginner", "Intermediate", "Advanced"].sample,
      price: Faker::Number.between(from: 0, to:200),
      user_id: teacher.id,
      published: true,
      approved: false
  )
  
  paid_course.image.attach(
    io:  File.open(File.join(Rails.root,'app/assets/images/Oprah-You-Get-A.jpeg')),
    filename: 'Oprah-You-Get-A.jpeg'
  )

  10.times do 
    lesson = Lesson.create(
      title: Faker::Educator.course_name,
      content: Faker::Markdown.sandwich
    )

    10.times do 
      paid_course_comment = Comment.create(
        user: student,
        content: Faker::Quote.famous_last_words,
      )
      
      lesson.comments << paid_course_comment
    end

    paid_course.lessons << lesson

  end

  student.enroll_to_course(paid_course)

  student.enrollments.each do |enrollment|
    enrollment.rating = Faker::Number.between(from: 0, to:5) 
    enrollment.review = Faker::Lorem.sentence
  end

  paid_course.save
end
    
# free course

free_course = Course.create(
  title: Faker::Educator.course_name,
  description: Faker::TvShows::GameOfThrones.quote,
  short_description: Faker::Quote.famous_last_words,
  language: Faker::ProgrammingLanguage.name,
  level: ["Beginner", "Intermediate", "Advanced"].sample,
  price: 0,
  user_id: teacher.id,
  published: true,
  approved: false
)

free_course.image.attach(
  io:  File.open(File.join(Rails.root,'app/assets/images/Oprah-You-Get-A.jpeg')),
  filename: 'Oprah-You-Get-A.jpeg'
)

10.times do 
  lesson = Lesson.create(
    title: Faker::Educator.course_name,
    content: Faker::Markdown.sandwich
  )
  
  10.times do 
    free_course_comment = Comment.create(
      user: student,
      content: Faker::Quote.famous_last_words,
    )
    
    lesson.comments << free_course_comment
  end

  free_course.lessons << lesson

end

student.enroll_to_course(free_course)

student.enrollments.each do |enrollment|
  enrollment.rating = Faker::Number.between(from: 0, to:5) 
  enrollment.review = Faker::Lorem.sentence
end

free_course.save
teacher.save
student.save
      
PublicActivity.enabled = true
