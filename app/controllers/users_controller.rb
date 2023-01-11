class UsersController < ApplicationController
    def index
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true) 
        @total_users = User.count
    end
end
