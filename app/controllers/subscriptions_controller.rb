class SubscriptionsController < ApplicationController
    def create
      @subscription = Subscription.new(user_id: @current_user.id, 
                                       partnership_id: subscription_params[:partnership_id])
      if @subscription.save
        render json: @subscription, status: :created
      else
        render json: {errors: @subscription.errors.full_messages}, status: :unprocessable_entity
      end      
    end

    def subscription_params
      params.permit(:partnership_id)
    end
end
