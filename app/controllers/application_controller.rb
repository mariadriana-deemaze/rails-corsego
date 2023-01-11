class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_global_variables, if: :user_signed_in?

    # track courses activities to current_user
    include PublicActivity::StoreController 

    def set_global_variables
        @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
    end

end
