class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  before_action :authenticate
  
  private
  
  def not_found
    render json: {
      error_message: 'Not found'
    }, status: :not_found
  end
  
  def authenticate
    authenticate_token || render_unauthorized
  end
  
  def authenticate_token
    authenticate_with_http_token do |token|
      current_user = User.find_by(token: token)
      if current_user
        @current_user = current_user
      else
        false
      end
    end
  end
  
  def render_unauthorized
    render json: {
        error_message: 'Bad credentials'
    }, status: :unauthorized
  end
end
