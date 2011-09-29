FactoryGirl.define do
	factory :everybody do
		name 'Everybody'
		accell_level 0
	end

	factory :member do
		name 'Member'
		access_level 700
	end

	factory :modeerator do
		name 'Moderator'
		access_level 800
	end

	factory :administrator do
		name 'Administrator'
		access_level 900
	end

	factory :super_administrator do
		name 'Super Administrator'
		access_level 1000
	end
end

