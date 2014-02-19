class Brewery < ActiveRecord::Base

	include RatingAverage

	validates :name, presence: true
	#validates :year, numericality: { greater_than_or_equal_to: 1042,
						#less_than_or_equal_to: 2014,
						
						#only_integer: true}
	#validate  :year_in_future
	validates :year, numericality: {greater_than_or_equal_to: 1042, less_than_or_equal_to:->(_){Time.now.year}}

	scope :active, ->{where active:true}
	scope :retired, ->{where active:[nil, false]}
	
	has_many :beers, :dependent => :destroy
	has_many :ratings, :through => :beers


	def self.top(n)
		i = n - 1
		sorted_by_rating_in_desc_order = Brewery.all.sort_by{|b| -(b.average_rating||0)}

		if sorted_by_rating_in_desc_order.length < n
			return sorted_by_rating_in_desc_order

		else

			return sorted_by_rating_in_desc_order[0..i]
		end


	end

	#def print_report
	#	puts self.name
	#	puts "established at year #{year}"
	#	puts "number of beers #{self.beers.count}"
	#	puts "number of ratings #{ratings.count}"
 	#end
	
	#def year_in_future

	#	if year.present? && year > Time.now.year
			#errors.add(:year, "can't be in the future")
	#	end	

	#end


	#def restart

	#	self.year = 2014
	#	puts "changed year to #{year}"
	#end
end
