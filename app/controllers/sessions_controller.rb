class SessionsController < ApplicationController
    skip_before_action :authenticate, only: [:create]
       
    def create
      @user = User.find_by_email(params[:email])
      if @user && @user.authenticate(params[:password])
        render json: @user.to_json(only: [:token]), status: :created
      else
        render json: {error_message: "Bad credentials"}, status: 404
      end
    end
      
    def destroy
      render json: {message: "Success logout"}, status: :ok
    end
      
    private
      
    def permit_params
      params.permit(:email, :password)
    end  
end
