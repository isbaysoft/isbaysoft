require 'spec_helper'

describe 'User Model' do
	describe 'association' do
		before(:each) do
			@rule = Factory :rule
			@usergroup = Factory :usergroup
			@user = Factory :user, 
				:access_level => @rule,
				:usergroup => @usergroup
		end

		it 'belongs_to rule' do
			@user.rule.should eq(@rule)
		end

		it 'belongs_to usergroup' do
			@user.usergroup.should eq(@usergroup)
		end

		after(:each) do
				@rule, @usergroup, @user = nil, nil, nil
		end
	end

	describe 'basic validation' do
		before(:each) do
			user_set = { :email => 'admin@mail.com', :access_level => 1000 }
			@user = Factory.build :user, user_set
		end

		it 'valid set' do
			@user.valid?.should be_true
		end

		it 'no valid email format' do
			@user.email = 'admin'
			@user.valid?.should be_false
		end

		it 'no valid access_level' do
			@user.access_level = nil
			@user.valid?.should be_false
		end
	end

	describe 'validation' do
		before(:each) do
			@user = Factory.build :user
		end

		describe 'validates access_level' do
			it 'should have error' do
				@user.should have(1).errors_on(:access_level)
			end
			it 'should not have error' do
				@user.access_level = 1000
				@user.should have(:no).errors_on(:access_level)	
			end
		end

		describe 'validates format of email' do
			it 'should have error' do
				@user.email = 'mail'
				@user.should have_at_least(1).error_on(:email)
			end

			it 'should not have error' do
				@user.email = 'user@mail.com'
				@user.should have(:no).errors_on(:email)
			end
		end

		describe 'validates uniqueness of email' do
			it 'should have error' do
				@user.access_level = 1000
				@user.save.should be_true
				
				#  Create new user_admin
				user = Factory.build :user_admin
				user.should have_at_least(1).error_on(:email)
			end
		end
	end
end
