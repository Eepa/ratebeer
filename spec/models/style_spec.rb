require 'spec_helper'

describe Style do
  		it "is saved with a proper name and description" do

			style = Style.create name:"UusiS", description:"vaalea"

			expect(style.valid?).to be(true)
			expect(Style.count).to eq(1)
		end

		it "is not saved without a name" do

			style = Style.create name:""

			expect(style.valid?).to be(false)
			expect(Style.count).to eq(0)
		end

		it "is saved without a description" do

			style = Style.create name:"UusiS"

			expect(style.valid?).to be(true)
			expect(Style.count).to eq(1)
		end

end
