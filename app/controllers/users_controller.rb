class UsersController < ApplicationController
    skip_before_action :authenticate, only: [:create]
    before_action :set_user, only: [:show, :update, :destroy]

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, serializer: UserSerializer, status: :created
      else
        render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
      end
    end
    
    def show
      render json: @user, serializer: UserSerializer
    end
    
    def update
      if @user.update(user_params)
        render json: @user, serializer: UserSerializer
      else
        render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def destroy
      if @user.destroy
        render status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:email, :name, :avatar, :password, :password_digest, :token)
    end

    def set_user
      @user = User.find_by(id: params[:id])
      render json: {"message": 'User not found'}, status: 422 unless @user
    end
end
