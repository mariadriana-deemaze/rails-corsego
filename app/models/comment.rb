class Comment < ApplicationRecord
    validates :content, presence: true
    belongs_to :user, counter_cache: true
    belongs_to :lesson, counter_cache: true

    # gem `public_activity`: track comment activities 
    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }

    def to_s
        content
    end
end
