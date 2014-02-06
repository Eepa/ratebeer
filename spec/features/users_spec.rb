require 'spec_helper'

include OwnTestHelper

describe "User" do
 # before :each do
    let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
    let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
    let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
    let!(:user) { FactoryGirl.create :user }
    
  #end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

	it "is redirected back to signin form if wrong credentials given" do

		sign_in(username:"Pekka", password:"wrong")
		
		expect(current_path).to eq(signin_path)

		expect(page).to have_content 'Username and password do not match!'
	end


	it "user page shows own ratings" do
		user2 = FactoryGirl.create :user, username:"Ukko"
		FactoryGirl.create(:rating, score:10, beer:beer1, user:user)
  		FactoryGirl.create(:rating, score:15, beer:beer2, user:user)
   		FactoryGirl.create(:rating, score:25, beer:beer1, user:user2)
   		FactoryGirl.create(:rating, score:35, beer:beer2, user:user2)
    	
		visit user_path(user)

		
		
		expect(page).to have_content 'Ratings'

   		expect(page).to have_content 'iso 3 10'

   		expect(page).to have_content 'Karhu 15' 

		expect(page).not_to have_content 'iso 3 35' 
		expect(page).not_to have_content 'Karhu 25' 
		
 	end


	it "when deleting a rating it is removed from database" do
		user2 = FactoryGirl.create :user, username:"Ukko"
		FactoryGirl.create(:rating, score:10, beer:beer1, user:user)
  		FactoryGirl.create(:rating, score:15, beer:beer2, user:user)
   		FactoryGirl.create(:rating, score:25, beer:beer1, user:user2)
   		FactoryGirl.create(:rating, score:35, beer:beer2, user:user2)
		sign_in(username:"Pekka", password:"Foobar1")
    	
		visit user_path(user)
			
		expect{
      			find(:xpath, "//a[@href='/ratings/2']").click
    		}.to change{Rating.count}.from(4).to(3) 
		
 	end
  end


	  it "when signed up with good credentials, is added to the system" do
    		visit signup_path
  		fill_in('user_username', with:'Brian')
    		fill_in('user_password', with:'Secret55')
    		fill_in('user_password_confirmation', with:'Secret55')

    		expect{
      			click_button('Create User')
    		}.to change{User.count}.by(1)
 	 end



 	
end
