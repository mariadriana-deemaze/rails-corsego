class Course < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

    validates :title, :short_description, :language, :price, :level, presence: true
    validates :description, presence:true, length: { :minimum => 5}

    belongs_to :user

    has_rich_text :description

    LANGUAGES = [:"English", :"Portuguese"]

    LEVELS = [:"Beginner", :"Intermedite", :"Advanced"]

    def to_s
        title
    end

    def self.languages 
        LANGUAGES.map{ |language| [language, language] }
    end

    def self.levels 
        LEVELS.map{ |level| [level, level] }
    end
end
