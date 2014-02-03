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
end
