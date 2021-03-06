class Style < ActiveRecord::Base


	include RatingAverage


	validates :name, presence: true

	has_many :beers, :dependent => :destroy

	def self.top(n)
		i = n - 1
		sorted_by_rating_in_desc_order = Style.all.sort_by{|b| -(b.score_for_style(b))}

		if sorted_by_rating_in_desc_order.length < n
			return sorted_by_rating_in_desc_order

		else

			return sorted_by_rating_in_desc_order[0..i]
		end


	end

	
end
