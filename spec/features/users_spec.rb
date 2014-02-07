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

	it "user page shows favorite brewery" do
		brewery = FactoryGirl.create(:brewery, name:"Testi")
		brewery2 = FactoryGirl.create(:brewery)
      			
		create_beer_with_rating_and_brewery(1, user, brewery)
		create_beer_with_rating_and_brewery(25, user, brewery2)
     		create_beer_with_rating_and_brewery(15, user, brewery2)
		create_beer_with_rating_and_brewery(15, user, brewery)
    	
		visit user_path(user)

		
		
		expect(page).to have_content "User's favorite brewery is anonymous"
   				
 	end

	it "user page shows favorite style" do
		create_beer_with_rating_and_style(25, user, "Lager")
		create_beer_with_rating_and_style(1, user, "Lager")
     		create_beer_with_rating_and_style(15, user, "IPA")
		create_beer_with_rating_and_style(15, user, "IPA")
     			
    		
    	
		visit user_path(user)

		
		
		expect(page).to have_content "User's favorite style is IPA"
   				
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


	  it "when signed up with bad credentials, is not added to the system" do
    		visit signup_path
  		
    		fill_in('user_password', with:'Secret55')
    		fill_in('user_password_confirmation', with:'Secret55')

    		
      		click_button('Create User')
		 
		expect(current_path).to eq(users_path)
		expect(User.count).to eq(1)
		expect(page).to have_content "Username is too short (minimum is 3 characters)"

		expect(page).to have_content "New user"


    		
 	 end


	  it "when updating with good input is updated correctly" do
    		sign_in(username:"Pekka", password:"Foobar1")
  		visit edit_user_path(user)

    		fill_in('user_password', with:'Secret55')
    		fill_in('user_password_confirmation', with:'Secret55')

    		
      		click_button('Update User')
		 
		expect(current_path).to eq(user_path(user))
		
		expect(page).to have_content "User was successfully updated."


		expect(page).to have_content "Username: Pekka"
    		
 	 end

 	 it "when updating with wrong input is not updated correctly" do
    		sign_in(username:"Pekka", password:"Foobar1")
  		visit edit_user_path(user)

    	   		
      		click_button('Update User')
		 
		expect(current_path).to eq(user_path(user))
		
		expect(page).to have_content "Password is invalid"


		expect(page).to have_content "Password is too short (minimum is 4 characters)"
    		
 	 end
	
	 it "when deleting user is removed from database" do
    		sign_in(username:"Pekka", password:"Foobar1")
  		visit user_path(user)

    	   		
      		click_link 'Destroy'
		 		
		
		expect(page).to have_content "Listing breweries"

    		
 	 end
	

	 it "signs correctly out" do
    		sign_in(username:"Pekka", password:"Foobar1")
  		click_link 'signout'
		 		
		
		expect(page).to have_content "Listing breweries"

    		
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

	def create_beer_with_rating_and_style(score, user, style)
		beer = FactoryGirl.create(:beer, style:style)

		FactoryGirl.create(:rating, score:score, beer:beer, user:user)
		beer
	end

	def create_beer_with_rating_and_brewery(score, user, brewery)
		beer = FactoryGirl.create(:beer, brewery:brewery)

		FactoryGirl.create(:rating, score:score, beer:beer, user:user)
		beer
	end

 	
end
