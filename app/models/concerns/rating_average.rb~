module RatingAverage
	extend ActiveSupport::Concern

	def average_rating
	   
	  ratings.average('score').to_i

	end
	
	#def average_rating_for_style(user,style)
	
	#	ratings_of_certain_style = user.ratings.select{ |rating| rating.beer.style == style }
	#	all_scores = []

	#	ratings_of_certain_style.each do |r|
#
	#		all_scores << r.score
	#	end

	#	total = all_scores.inject(:+)
	#	lenght = 3
	#	average = total.to_f / length

	#	return average
	
	#end

end
