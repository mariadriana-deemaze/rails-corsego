class Lesson < ApplicationRecord
  validates :title, :content, :course, presence: true
  
  belongs_to :course, counter_cache: true
  
  has_many :user_lessons

  has_rich_text :content

  # gem `friendly_id`: adds lesson slug by title
  extend FriendlyId
  friendly_id :title, use: :slugged

  def viewed_by_user(user) 
    self.user_lessons.where(user: user).present?
  end

end
