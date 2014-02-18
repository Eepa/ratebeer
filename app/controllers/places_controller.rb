class PlacesController < ApplicationController

	def index
	end

	def search 
		
		@places = BeermappingApi.places_in(params[:city])
		session[:city] = params[:city]
		
		if @places.empty?

			redirect_to places_path, :notice => "No locations in #{params[:city]}"

		else
			
			render :index
		end

	end

	def show
		session[:place_id] = params[:id]
		@places = BeermappingApi.places_in(session[:city])

		@place = @places.find{|p| p.id==session[:place_id]}

	end

end
