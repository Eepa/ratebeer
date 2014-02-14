class Style < ActiveRecord::Base


	include RatingAverage


	validates :name, presence: true

	has_many :beers, :dependent => :destroy
end
