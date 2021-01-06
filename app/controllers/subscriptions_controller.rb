class SubscriptionsController < ApplicationController
    def create
      @subscription = Subscription.new(subscription_params)
      if @subscription.save
        render json: @subscription, status: :created
      else
        render json: {errors: @subscription.errors.full_messages}, status: :unprocessable_entity
      end      
    end

    def subscription_params
      params.permit(:user_id, :partnership_id)
    end
end
