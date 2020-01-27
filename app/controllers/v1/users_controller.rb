module V1
  class UsersController < ApplicationController
    def create
      user = User.new(user_params)

      if user.save
        render json: user, status: :created
      else 
        head(:unauthorized)
      end
    end

    def destroy
      user = User.all.where(id: params[:id]).first
  
      if user
        user.destroy
        render json: { message: 'User was succesfully removed' }
      else
        render json: {
          error: "User with id #{params[:id]} not found."
        }, status: :not_found
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end