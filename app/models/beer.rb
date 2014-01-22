class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings, :dependent => :destroy

	def average_rating
	   
	  ratings.average('score').to_i

	end

	def to_s 
		"#{name}, panimo: #{brewery.name}"
	end

end
