require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  #before :each do
   # sign_in(username:"Pekka", password:"Foobar1")
    
  #end

  it "when given, is registered to the beer and user who is signed in" do
	sign_in(username:"Pekka", password:"Foobar1")
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

   it "when given, is registered to the beer and user who is signed in" do
	
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    
    click_button "Create Rating"
    expect(current_path).to eq(signin_path)

    expect(user.ratings.count).to eq(0)
    expect(beer1.ratings.count).to eq(0)
    expect(beer1.average_rating).to eq(nil)
	expect(page).to have_content "You should be signed in"
  end

	

  it "when there are ratings they are shown in ratings page" do
	sign_in(username:"Pekka", password:"Foobar1")
    FactoryGirl.create(:rating, score:10, beer:beer1, user:user)
    FactoryGirl.create(:rating, score:15, beer:beer2, user:user)
    FactoryGirl.create(:rating, score:25, beer:beer1, user:user)
    FactoryGirl.create(:rating, score:35, beer:beer2, user:user)
	
    visit ratings_path




    expect(page).to have_content 'Number of ratings: 4'

	
    expect(page).to have_content 'iso 3 10 Pekka'
    expect(page).to have_content 'Karhu 15 Pekka'
    expect(page).to have_content 'iso 3 25 Pekka'
    expect(page).to have_content 'Karhu 35 Pekka'

  end





end
