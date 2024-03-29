class Enrollment < ApplicationRecord
  validates :user, :course, presence: true
  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id
  validates_presence_of :rating, if: :review?
  validates_presence_of :review, if: :rating?
  validate :cant_subscribe_to_own_course
  
  belongs_to :user, counter_cache: true
  belongs_to :course, counter_cache: true
  
  scope :pending_review, -> { where(rating: [0, nil, ""], review:[0,nil,""]) }
  scope :reviewed,       -> { where.not(review: [0, nil, ""]) }
  scope :latest_reviews, -> { order(created_at: :desc, rating: :desc).limit(3) }
  
  after_save do
    unless rating.nil? || rating.zero?
      course.update_rating
    end
  end

  after_destroy do 
    course.update_rating
  end

  # gem `friendly_id`: adds course slug by title
  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def to_s 
    user.to_s + " " + course.to_s
  end


  protected
  def cant_subscribe_to_own_course 
    if self.new_record? 
      if self.user_id.present?
        if user_id == course.user_id
          errors.add(:base, "You can not subscribe to your own course")
        end
      end
    end
  end

end
