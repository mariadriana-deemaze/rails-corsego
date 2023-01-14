class UsersController < ApplicationController
    before_action :set_user, only:[:edit, :update, :show]

    def index
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true) 
        @total_users = User.count
        authorize @users
    end

    def show 
    end

    def edit
        authorize @user
    end

    def update
        if @user.update(user_params) 
            redirect_to users_path 
            flash.now[:success] = "User #{@user.email} was successfully updated"
        else
            render :edit
        end
    end

    private

    def set_user 
        @user = User.friendly.find(params[:id])
    end

    def user_params
        params.require(:user).permit({role_ids:[]})
    end
end
