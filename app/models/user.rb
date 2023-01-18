class User < ApplicationRecord
  validate :must_have_a_role, on: :update

  after_create :assign_default_role
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_many :courses
  has_many :enrollments
  has_many :user_lessons

  # gem `friendly_id`: adds user slug by email
  extend FriendlyId
  friendly_id :email, use: :slugged

  # gem `rolify`: associate with user roles
  rolify

  def to_s
    email
  end     
  
  def assign_default_role
    self.add_role(:student) if self.roles.blank?
  end

  def online? 
    updated_at > 2.minutes.ago
  end

  def enroll_to_course(course)
    self.enrollments.create(course: course, price: course.price)
  end

  def mark_as_viewed(lesson)
    unless self.user_lessons.where(lesson: lesson).any? 
      self.user_lessons.create(lesson: lesson)
    end
  end

  private 

  def must_have_a_role 
    unless roles.any?
      errors.add(:roles, "must have atleast one role")
    end
  end
end
