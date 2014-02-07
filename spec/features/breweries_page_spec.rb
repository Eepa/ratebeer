require 'spec_helper'





describe "Breweries page" do


  it "should not have any before been created" do
    visit breweries_path
    expect(page).to have_content 'Listing breweries'

    expect(page).to have_content 'Number of breweries: 0'
  end


	describe "when breweries exists" do

		before :each do 

			@breweries = ["Koff", "Karjala", "Schlenkerla"]
			year = 1896
  	  		@breweries.each do |brewery_name|
				FactoryGirl.create(:brewery, name:brewery_name, year: year += 1)
			end  	  	 

   	 		visit breweries_path
		end

	 	it "lists the existing breweries and their total number" do



    			expect(page).to have_content "Number of breweries: #{@breweries.count}"

    			@breweries.each do |brewery_name|
     				expect(page).to have_content brewery_name
    			end
  		end

  		it "allows user to navigate to page of a Brewery" do
    
      			click_link "Koff"

    			expect(page).to have_content "Koff"

    			expect(page).to have_content "Established year: 1897"
   
  		end

		#it "when deleting a brewery is removed from database" do

		
    	
			#visit breweries_path
			#save_and_open_page

			#find(:xpath, "(//a[text()='Destroy'])[2]").click
			#page.driver.browser.authorize 'admin', 'secret'

			#basic_auth('admin', 'secret')
    			#expect(Brewery.count).to eq(2)

		#end


		it "when editing a brewery correctly is updated and redirected correctly" do
			visit breweries_path
			

			find(:xpath, "//a[@href='/breweries/2/edit']").click
			
			fill_in('brewery[name]', with:'Test1')

			fill_in('brewery[year]', with:'2013')

			click_button "Update Brewery"

			expect(page).to have_content "Brewery was successfully updated."
			expect(page).to have_content "Name: Test1" 
		
    			expect(page).to have_content "Established year: 2013"

		end


		it "when editing a brewery incorrectly is not updated and is redirected correctly" do
			visit breweries_path
			

			find(:xpath, "//a[@href='/breweries/2/edit']").click
			
			fill_in('brewery[name]', with:"")

			fill_in('brewery[year]', with:'2013')

			click_button "Update Brewery"

			expect(page).to have_content "Name can't be blank"
			expect(page).to have_content "Editing brewery" 
		

		end
	end

	
	it "when created with right parameters is created correctly and redirected to brewery page" do

  		visit new_brewery_path
    		
    		fill_in('brewery[name]', with:'Test')

		fill_in('brewery[year]', with:'2012')

    		expect{
      			click_button "Create Brewery"
   		}.to change{Brewery.count}.from(0).to(1)

		expect(page).to have_content "Name: Test" 

		expect(page).to have_content "Established year: 2012"

    	

	end


		it "when created with wrong parameters is not created and is redirected to brewery page" do

  		visit new_brewery_path
    		
    		

		fill_in('brewery[year]', with:'2012')

    		
      		click_button "Create Brewery"
   	
		expect(Brewery.count).to eq(0)

		expect(current_path).to eq(breweries_path)
		expect(page).to have_content "New brewery" 

		expect(page).to have_content "Name can't be blank"

    	

	end



	#def basic_auth(name, password) 
		#if page.driver.respond_to?(:basic_auth)
		#	page.driver.basic_auth(name, password)
		#elsif page.driver.respond_to?(:basic_authorize)
		#	page.driver.basic_authorize(name, password)
		#elsif page.driver.respond_to?(:basic_browser) && page.driver.respond_to?(:basic_authorize)

		#	page.driver.browser.basic_authorize(name, password)
		#else
		#	raise "I don't know how to log in!"
		#end

			

	#end
	


end
