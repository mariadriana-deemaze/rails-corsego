class Enrollment < ApplicationRecord
  validates :user, :course, presence: true
  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id
  validate :cant_subscribe_to_own_course
  
  belongs_to :user
  belongs_to :course


  scope :pending_review, -> { where(rating: [0, nil, ""], review:[0,nil,""]) }

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
