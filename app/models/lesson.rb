class Lesson < ApplicationRecord
  validates :title, :content, :course, presence: true
  
  belongs_to :course
  
  # gem `friendly_id`: adds lesson slug by title
  extend FriendlyId
  friendly_id :title, use: :slugged
end
