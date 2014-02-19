module RatingAverage
	extend ActiveSupport::Concern

	def average_rating
	   
	 # ratings.average('score').to_i
		ratings.average :score

	end
	
	

	def score_for_style(style)
		return 0 if Rating.all.select{ |rating| rating.beer.style == style}.size == 0

		sum_of_ratings = Rating.all.select{ |r| r.beer.style == style}.inject(0){ |sum, r| sum + r.score}

		amount_of_ratings = Rating.all.select{ |rating| rating.beer.style == style}.size

		average = sum_of_ratings / amount_of_ratings

	end

end
