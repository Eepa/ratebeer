FactoryGirl.define do

	factory :user do

		username "Pekka"
		password "Foobar1"
		password_confirmation "Foobar1"

	end

	factory :rating do

		score 10
	end

	factory :rating2, class: Rating do
		score 20
	end

	factory :brewery do
		name "anonymous"
		year 1900
		active true
	end

	factory :beer do
		name "anonymous"
		brewery
		style
	end

	factory :style do
		name "IPA"
		description "Ihan perus olut"
	end
	
	factory :style2, class: Style do
		name "Lager"
		description "vaalea"
	end
	

end
