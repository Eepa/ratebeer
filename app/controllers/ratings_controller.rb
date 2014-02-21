class RatingsController < ApplicationController
	def index

		# Hoidettu taustaprosessoinnilla
		# sillä jutulla, mikä oli materiaalissa, missä tarkistettiin, onko haluttu tieto 
		# välimuistissa. Jos se on niin ladataan sieltä, muuten kirjoitetaan se sinne.
		
		Rails.cache.write("ratings all", Rating.all, expires_in: 10.minutes) unless not_in_cache("ratings all")

		@ratings = Rails.cache.read "ratings all" 

		Rails.cache.write("best beers", Beer.top(3), expires_in: 10.minutes) unless not_in_cache("best beers")

		@best_beers = Rails.cache.read "best beers"

		Rails.cache.write("best breweries", Brewery.top(3), expires_in: 10.minutes) unless not_in_cache("best breweries")
		@best_breweries = Rails.cache.read "best breweries"
		
		Rails.cache.write("best users", User.top(3), expires_in: 10.minutes) unless not_in_cache("best users")

		@best_users = Rails.cache.read "best users"

		Rails.cache.write("recent ratings", Rating.last_five, expires_in: 10.minutes) unless not_in_cache("recent ratings")
		@recent_ratings = Rails.cache.read "recent ratings"

		Rails.cache.write("best styles", Style.top(3), expires_in: 10.minutes) unless not_in_cache("best styles")
		@best_styles = Rails.cache.read "best styles"

	end

	def not_in_cache(id)
		Rails.cache.exist?(id)
	end

	#def background_cacher

		#while true do
		#	sleep 20.minutes
		
			#Rails.cache.write("ratings all", Rating.all)

			#Rails.cache.write("best beers", Beer.top(3))

			#Rails.cache.write("best breweries", Brewery.top(3))
			
			#Rails.cache.write("best users", User.top(3))
			
			#Rails.cache.write("best styles", Style.top(3))

			#Rails.cache.write("recent ratings", Rating.last_five)
		
			
		#end

	#end
	
	def new
		@rating  = Rating.new
		@beers = Beer.all
	end

	def create
		@rating = Rating.new params.require(:rating).permit(:score, :beer_id)
		
		if current_user.nil?
			redirect_to signin_path, notice:'You should be signed in'
		elsif @rating.save		
			current_user.ratings << @rating
			redirect_to current_user
		else 
			@beers = Beer.all
			render :new
		end

	end
	
	def destroy
		rating = Rating.find(params[:id])
		rating.delete if current_user == rating.user
		redirect_to :back
	end

	


end	
