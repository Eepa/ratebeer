class BeerClub < ActiveRecord::Base

	validates :name, presence: true
	validates :founded, numericality: { greater_than_or_equal_to: 1042,
						#less_than_or_equal_to: 2014,
						
						only_integer: true}
	validate  :founded_not_in_future

	has_many :memberships, :dependent => :destroy
	has_many :users, through: :memberships

	def to_s
		"#{name}"
	end

	def founded_not_in_future

		if founded.present? && founded > Time.now.year
			errors.add(:founded, "can't be in the future")
		end	

	end
end
