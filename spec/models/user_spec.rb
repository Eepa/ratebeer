require 'spec_helper'

describe User do
  
	it "has the username set correctly" do 
		user = User.new username:"Pekka"
		
		#expect(user.username).to be("Pekka")
		user.username.should == "Pekka"

	end

	it "is not saved without a password" do

		user = User.create username:"Pekka"

		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end


	describe "with a proper password" do 

		let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"}

		it "is saved" do
			expect(user.valid?).to be(true)
			expect(User.count).to eq(1)
		end
		


		it "and with two ratings, has the correct average rating" do
		
   			rating = Rating.new score:10
			rating2 = Rating.new score:20

    			user.ratings << rating
    			user.ratings << rating2

    			expect(user.ratings.count).to eq(2)
    			expect(user.average_rating).to eq(15.0)
  		end
	end

	it "is not saved with a too short password" do

		user = User.create username:"Pekka", password:"eS1", password_confirmation:"eS1"
		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end

	it "is not saved with a password with only letters" do

		user = User.create username:"Pekka", password:"Testi", password_confirmation:"Testi"
		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end

end
