require 'spec_helper'
include OwnTestHelper

describe "Style" do
  
	
  let!(:user) { FactoryGirl.create :user, admin:true }
 

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
    
  end

  it "can be created, when given proper name" do

    
    visit new_style_path

    
    fill_in('style[name]', with:"uusiTyyli")
    fill_in('style[description]', with:"uusiTyyli kuvaus")

    expect{
      click_button "Create Style"
    }.to change{Style.count}.from(0).to(1)

  end

  it "won't be created and the page redirects back to creation page, when given false name" do
    visit new_style_path
    
    
    fill_in('style[description]', with:"uusiTyyli kuvaus")

    click_button "Create Style"
  	
	amount = Style.count
	expect(amount).to eq(0) 

	expect(current_path).to eq(styles_path)
	
	expect(page).to have_content "Name can't be blank"

  end

		it "when deleting a style it is removed from database" do
			
			style = FactoryGirl.create(:style)
		
    			beer = FactoryGirl.create(:style2)
			visit style_path(style)
			
			expect{
      				click_link "Destroy"
   			}.to change{Style.count}.from(2).to(1)

			

		end


		it "when editing a style correctly is updated and redirected correctly" do
			
			style = FactoryGirl.create(:style)

			visit edit_style_path(style)
			
			
			fill_in('style[name]', with:'Testi1')


			click_button "Update Style"

			expect(page).to have_content "Style was successfully updated."
			expect(page).to have_content "Name: Testi1" 
		

		end


		it "when editing a style incorrectly is not updated and is redirected correctly" do

			style = FactoryGirl.create(:style)

			visit edit_style_path(style)

			#save_and_open_page
	
			fill_in('style[name]', with:"")
			

			click_button "Update Style"

			expect(page).to have_content "Name can't be blank"
			
			#expect(page).to have_content "Update Beer"

		end

end
