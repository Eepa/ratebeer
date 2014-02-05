require 'spec_helper'
include OwnTestHelper

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
    
  end

  it "can be created, when given proper name" do
    visit new_beer_path
    select('IPA', from:'beer[style]')
    fill_in('beer[name]', with:"uusiOlut")
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

  end

  it "won't be created and the page redirects back to creation page, when given false name" do
    visit new_beer_path
    select('IPA', from:'beer[style]')
    
    select('Koff', from:'beer[brewery_id]')

    click_button "Create Beer"
  	
	amount = Beer.count
	expect(amount).to eq(0) 

	expect(current_path).to eq(new_beer_path)
	
	expect(page).to have_content 'Beer cannot be created without a name.'

  end

end
