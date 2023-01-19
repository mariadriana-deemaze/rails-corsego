class ChartsController < ApplicationController
    def users_per_hour
      render json: User.group_by_hour(:created_at).count
    end
    def enrollments_per_day
      render json: Enrollment.group_by_day(:created_at).count
    end
end
