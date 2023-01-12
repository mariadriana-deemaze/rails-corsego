class Lesson < ApplicationRecord
  belongs_to :course
  validates :title, :content, :course, presence: true

  # gem `friendly_id`: adds lesson slug by title
  extend FriendlyId
  friendly_id :title, use: :slugged
end
