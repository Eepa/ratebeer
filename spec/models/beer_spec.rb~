require 'spec_helper'

describe Beer do
	describe "with a proper style" do
		let(:style){ style = FactoryGirl.create(:style) }

		it "is saved with a proper name" do

			beer = Beer.create name:"Testiolut", style:style

			expect(beer.valid?).to be(true)
			expect(Beer.count).to eq(1)
		end


		it "is not saved without a name" do

			beer = Beer.create name:"", style:style

			expect(beer.valid?).to be(false)
			expect(Beer.count).to eq(0)
		end
	end

		it "is not saved without a style" do

			beer = Beer.create name:"testi"

			expect(beer.valid?).to be(false)
			expect(Beer.count).to eq(0)
		end

end
