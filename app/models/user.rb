class User < ApplicationRecord
  after_create :assign_default_role
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_many :courses

  # associate with the rolify gem as the model that uses roles
  rolify

  def to_s
    email
  end     
  
  def assign_default_role
    self.add_role(:student) if self.roles.blank?
  end
   
end
