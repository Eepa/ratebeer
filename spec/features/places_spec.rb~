require 'spec_helper'

describe "Places" do

	it "if one is returned by the API, it is shown at the page" do

		BeermappingApi.stub(:places_in).with("kumpula").and_return(

			[ Place.new(:name => "Oljenkorsi") ]
		)

		visit places_path

		fill_in('city', with: 'kumpula')
		click_button "Search"

		expect(page).to have_content "Oljenkorsi"

	end

	it "if more are returned by the API, it is shown at the page" do

		BeermappingApi.stub(:places_in).with("kumpula").and_return(

			[ Place.new(:name => "Oljenkorsi"), Place.new(:name => "Oljenvarsi"),
				Place.new(:name => "Olkikatto") ]
		)

		visit places_path

		fill_in('city', with: 'kumpula')
		click_button "Search"

		expect(page).to have_content "Oljenkorsi"
		expect(page).to have_content "Oljenvarsi"
		expect(page).to have_content "Olkikatto"

	end

		it "if none are returned by the API, notice is shown at the page" do

		BeermappingApi.stub(:places_in).with("kumpula").and_return(

			[ ]
		)

		visit places_path

		fill_in('city', with: 'kumpula')
		click_button "Search"

		expect(page).to have_content "No locations in kumpula"

	end



end
