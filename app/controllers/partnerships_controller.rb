class PartnershipsController < ApplicationController
    before_action :set_partnership, only: [:show, :update, :destroy]

    def create
      @partnership = Partnership.new(partnership_params)
      if @partnership.save
        render json: @partnership, serializer: PartnershipSerializer, status: :created
      else
        render json: {errors: @partnership.errors.full_messages}, status: :unprocessable_entity
      end
    end
    
    def show
      render json: @partnership, serializer: PartnershipSerializer
    end
    
    def update
      if @partnership.update(partnership_params)
        render json: @partnership, serializer: PartnershipSerializer
      else
        render json: {errors: @partnership.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def destroy
      if @partnership.destroy
        render status: :ok
      else
        render json: @partnership.errors, status: :unprocessable_entity
      end
    end

    private

    def partnership_params
      params.permit(:title, :description, :files => [])
    end

    def set_partnership
      @partnership = Partnership.find_by(id: params[:id])
      render json: {"message": 'Partnership not found'}, status: 422 unless @partnership
    end
end
