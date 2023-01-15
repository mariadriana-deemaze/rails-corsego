class UsersController < ApplicationController
    before_action :set_user, only:[:edit, :update, :show]

    def index
        @q = User.ransack(params[:q])
        @total_users = User.count

        # gem 'pagy': paginate collection
        @pagy, @users = pagy(@q.result(distinct: true) )

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
