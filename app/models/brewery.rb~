class Brewery < ActiveRecord::Base

	include RatingAverage

	validates :name, presence: true
	validates :year, numericality: { greater_than_or_equal_to: 1042,
						#less_than_or_equal_to: 2014,
						
						only_integer: true}
	validate  :year_in_future
	
	has_many :beers, :dependent => :destroy
	has_many :ratings, :through => :beers

	#def print_report
	#	puts self.name
	#	puts "established at year #{year}"
	#	puts "number of beers #{self.beers.count}"
	#	puts "number of ratings #{ratings.count}"
 	#end
	
	def year_in_future

		if year.present? && year > Time.now.year
			errors.add(:year, "can't be in the future")
		end	

	end


	#def restart

	#	self.year = 2014
	#	puts "changed year to #{year}"
	#end
end
