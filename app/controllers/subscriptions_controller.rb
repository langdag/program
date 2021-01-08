class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:block, :unblock]

  def create
    @subscription = Subscription.new(user_id: @current_user.id,
                                       partnership_id: subscription_params[:partnership_id])
    if @subscription.save
      render json: @subscription, status: :created
    else
      render json: {errors: @subscription.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def block
    return render json: {"message": 'Subscription already blocked'}, status: 422 if already_blocked?
    if @subscription.update(blocked: true)
      render json: {message: 'Subscription successfully blocked'}, status: :ok
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  def unblock
    return render json: {"message": 'Subscription already unblocked'}, status: 422 unless @subscription.blocked?
    if @subscription.update(blocked: false)
      render json: {message: 'Subscription successfully unblocked'}, status: :ok
    else
       render json: @current_user.errors, status: 422
    end
  end

  private

  def subscription_params
    params.permit(:partnership_id)
  end

  def set_subscription
    @subscription = Subscription.find_by(id: params[:id])
    render json: {"message": 'Subscription not found'}, status: 422 unless @subscription
  end

  def already_blocked?
    @subscription.blocked?
  end
end
