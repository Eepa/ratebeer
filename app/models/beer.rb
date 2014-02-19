class Beer < ActiveRecord::Base

	include RatingAverage

	validates :name, presence: true
	#validates :style, presence: true
	#validates :style

	belongs_to :brewery
	belongs_to :style
	has_many :ratings, :dependent => :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user

	
	def to_s 
		"#{name}, panimo: #{brewery.name}"
	end

	def self.top(n)
		i = n - 1
		sorted_by_rating_in_desc_order = Beer.all.sort_by{|b| -(b.average_rating||0)}

		if sorted_by_rating_in_desc_order.length < n
			return sorted_by_rating_in_desc_order

		else

			return sorted_by_rating_in_desc_order[0..i]
		end


	end

end
