class Course < ApplicationRecord
    validates :title, :short_description, :language, :price, :level, presence: true
    validates :description, presence:true, length: { :minimum => 5}
    
    belongs_to :user, counter_cache: true

    has_many :lessons, dependent: :destroy
    has_many :enrollments, dependent: :restrict_with_error
    has_many :user_lessons, through: :lessons
    has_many :course_tags, inverse_of: :course, dependent: :destroy
    has_many :tags, through: :course_tags

    has_rich_text :description

    has_one_attached :image

    validates :title, uniqueness: true, length: { maximum: 70 }
    validates :price, numericality: { greater_than_or_equal_to: 0 }

    validates :image, presence: true, 
    content_type: ['image/png', 'image/jpg', 'image/jpeg'], 
    size: { less_than: 500.kilobytes , message: 'size should be under 500 kilobytes' }

    scope :latest,      -> { limit(3).order(created_at: :desc) }
    scope :top_rated,   -> { limit(3).order(average_rating: :desc, created_at: :desc) }
    scope :popular,     -> { limit(3).order(enrollments_count: :desc, created_at: :desc) }
    scope :published,   -> { where(published: true) }
    scope :approved,    -> { where(approved: true) }
    scope :unpublished, -> { where(published: false) }
    scope :unapproved,  -> { where(approved: false) }

    
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

    def progress(user)
        unless self.lessons_count == 0 
            user_lessons.where(user: user).count/self.lessons_count.to_f * 100
        end
    end

    def update_rating 
        if enrollments.any? && enrollments.where.not(rating:nil).any?
            update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
        else
            update_column :average_rating, (0)
        end
    end
end
