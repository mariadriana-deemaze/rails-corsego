class UserLesson < ApplicationRecord
    validates :user, :lesson, presence: :true

    # user can't see the same lesson more that one times as the first time
    validates_uniqueness_of :user_id,   scope: :lesson_id 
    validates_uniqueness_of :lesson_id, scope: :user_id
    
    belongs_to :user
    belongs_to :lesson
end
