class HomeController < ApplicationController
    skip_before_action :authenticate_user!, :only => [:index]
    def index
        @courses = Course.all.limit(3)
        @latest_courses = Course.all.limit(3).order(created_at: :desc)
        @sliders = [
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
