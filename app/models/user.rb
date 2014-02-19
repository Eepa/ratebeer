class User < ActiveRecord::Base

	include RatingAverage

	has_secure_password

	validates :username, uniqueness: true, length: {minimum:3, maximum: 15}
	validates_format_of :password, :with => /\A(([0-9]|[a-z]|[A-Z])*([0-9])([0-9]|[a-z]|[A-Z])*([A-Z])([0-9]|[a-z]|[A-Z])*|([0-9]|[a-z]|[A-Z])*([A-Z])([0-9]|[a-z]|[A-Z])*([0-9])([0-9]|[a-z]|[A-Z])*)\z/
	validates :password, length: {minimum:4}

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships

	def favorite_beer
		return nil if ratings.empty?
		ratings.order(score: :desc).limit(1).first.beer
	end

	def self.top(n)
		i = n - 1
		sorted_by_rating_in_desc_order = User.all.sort_by{|b| -(b.average_rating||0)}

		if sorted_by_rating_in_desc_order.length < n
			return sorted_by_rating_in_desc_order

		else

			return sorted_by_rating_in_desc_order[0..i]
		end


	end


	def favorite_style
		return nil if ratings.empty?
		

		all_styles = ratings.map{ |r| r.beer.style }.uniq

		highest = 0
		best_style = nil

		all_styles.each do |style|
			sum_of_ratings = ratings.select{ |r| r.beer.style == style}.inject(0){ |sum, r| sum + r.score}

			amount_of_ratings = ratings.select{ |rating| rating.beer.style == style}.size

			average = sum_of_ratings / amount_of_ratings

			if average > highest
				best_style = style
				highest = average
			end
		end
		best_style
	end

	def favorite_brewery
		return nil if ratings.empty?
		

		all_breweries = ratings.map{|r| r.beer.brewery_id}.uniq

		highest = 0
		best_brewery = nil
		

		all_breweries.each do |brewery|
			sum_of_ratings = ratings.select{|r| r.beer.brewery_id == brewery}.inject(0){|sum, r|sum + r.score}

			amount_of_breweries = ratings.select{|r| r.beer.brewery_id == brewery}.size

			average = sum_of_ratings / amount_of_breweries
			if average > highest
				best_brewery = brewery
				highest = average
			end

		end
		best = Brewery.find best_brewery
		best.name	
	end

	


	
end
