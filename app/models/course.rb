class Course < ApplicationRecord
    validates :title, :short_description, :language, :price, :level, presence: true
    validates :description, presence:true, length: { :minimum => 5}
    validates :price, numericality: { less_than: 10000000 }
    
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
    
    # This is your test secret API key.
    Stripe.api_key = Rails.application.credentials[:stripe][:private_key]

    # gem `stripe`: create stripe product after create
    after_create :create_stripe_product
    after_save :update_stripe_product
    
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

    def price_as_cents(price)
        price * 100 
    end

    def create_stripe_product 
        image_path = root_url +  Rails.application.routes.url_helpers.rails_blob_path(self.image, only_path: true)
        stripe_product = Stripe::Product.create(name: title, images:[image_path])
        stripe_price = Stripe::Price.create(product: stripe_product, unit_amount: price_as_cents(self.price), currency: self.currency)
        update(stripe_product_id: stripe_product.id, stripe_price_id: stripe_price.id)
    end

    def update_stripe_product 
        image_path = root_url +  Rails.application.routes.url_helpers.rails_blob_path(self.image, only_path: true)

        Stripe::Product.update(
            self.stripe_product_id,
            { name: self.title, images:[image_path] },
        )

        current_price = Stripe::Price.retrieve(self.stripe_price_id)[:unit_amount]/100 
        
        unless self.price == current_price
            # disable old
            Stripe::Price.update(
                self.stripe_price_id,
                { active: false },
            )

            #create new
            stripe_product = Stripe::Product.retrieve(self.stripe_product_id)
            stripe_price = Stripe::Price.create(product: stripe_product, unit_amount: price_as_cents(self.price), currency: self.currency)
            update(stripe_price_id: stripe_price.id)
            save
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
