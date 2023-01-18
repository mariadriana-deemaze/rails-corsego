class HomeController < ApplicationController
    skip_before_action :authenticate_user!, :only => [:index]
    def index
        @courses            = Course.all.limit(3)
        @latest_courses     = Course.all.order(created_at: :desc).limit(3)
        @top_rated_courses  = Course.order(average_rating: :desc, created_at: :desc).limit(3)
        @popular_courses    = Course.order(enrollments_count: :desc, created_at: :desc).limit(3)
        @purchased_courses  = Course.joins(:enrollments).where(enrollments: { user: current_user }).order(created_at: :desc).limit(3)
        @reviews            = Enrollment.reviewed.order(created_at: :desc, rating: :desc).limit(3)
        
        @sliders            = [
            "https://source.unsplash.com/random/?fruit",
            "https://source.unsplash.com/random/?car", 
            "https://source.unsplash.com/random/?person", 
            "https://source.unsplash.com/random/?magazine", 
            "https://source.unsplash.com/random/?plant"
        ]
    end

    def activities
        @activities = PublicActivity::Activity.all
    end
end
