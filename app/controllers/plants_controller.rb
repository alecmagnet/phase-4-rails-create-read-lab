class PlantsController < ApplicationController
	wrap_parameters format: []

	def index
		plants = Plant.all 
		render json: plants, except: [:created_at, :updated_at] 
	end

	def show
		plant = Plant.find_by(id: params[:id])
		render json: plant, except: [:created_at, :updated_at] 
	end

	def create 
		plant = Plant.create!(plant_params)
		render json: plant, status: :created
	rescue ActiveRecord::RecordInvalid => invalid
  	render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
	end

	private

	def plant_params
		params.permit(:name, :image, :price)
	end

end
