class HomeController < ApplicationController
    skip_before_action :authenticate_user!, :only => [:index]
    def index
        @courses            = Course.all.limit(3)
        @latest_courses     = Course.reviewed.latest
        @top_rated_courses  = Course.top_rated
        @popular_courses    = Course.popular
        @purchased_courses  = Course.joins(:enrollments).where(enrollments: { user: current_user }).order(created_at: :desc).limit(3)
        @reviews            = Enrollment.latest_reviews
        
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
