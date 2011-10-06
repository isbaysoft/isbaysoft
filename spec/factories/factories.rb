FactoryGirl.define do
  factory :rule do
	  name 'Everybody'
		access_level 1000
	end

	factory :user do
	  email 'user@mail.com'
		password 'password'
		password_confirmation 'password'
	end

	factory :user_admin, :parent => :user do
		access_level 1000	
	end

	factory :usergroup do
		name 'new_usergroup'
	end
end