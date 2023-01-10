class UsersController < ApplicationController
    def index
        @q = User.ransack(params[:q])
        @total_users = User.count
        @users = @q.result(distinct: true) 
    end
end
