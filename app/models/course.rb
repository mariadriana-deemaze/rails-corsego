class Course < ApplicationRecord
    validates :title, :short_description, :language, :price, :level, presence: true
    validates :description, presence:true, length: { :minimum => 5}
    
    belongs_to :user

    has_many :lessons, dependent: :destroy
    has_many :enrollments

    has_rich_text :description
    
    LANGUAGES = [:"English", :"Portuguese"]
    LEVELS = [:"Beginner", :"Intermediate", :"Advanced"]
    
    # gem `friendly_id`: adds course slug by title
    extend FriendlyId
    friendly_id :title, use: :slugged

    # gem `public_activity`: track courses activities 
    include PublicActivity::Model
    # https://github.com/public-activity/public_activity/issues/54
    tracked owner: Proc.new{ |controller, model|  PublicActivity.set_controller(@controller) && controller.current_user }

    def to_s
        title
    end

    def self.languages 
        LANGUAGES.map{ |language| [language, language] }
    end

    def self.levels 
        LEVELS.map{ |level| [level, level] }
    end

    def bought(user)
        !self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
    end

    def update_rating 
        if enrollments.any? && enrollments.where.not(rating:nil).any?
            update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
        else
            update_column :average_rating, (0)
        end
    end
end
