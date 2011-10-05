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
	end

	describe 'validation' do
		before(:each) do
			@user = Factory.stub :user
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
			it 'should have error for (mail)' do
				@user.email = 'mail'
				@user.should have(1).errors_on(:email)	

			end
		end


		# describe 'validates uniqueness of email' do
		# 	describe 'should not have error'
		# end

		# it 'validates_uniqueness_of :email' do
			# user = Factory.stub :user
			# user.valid?.sho	uld be_false
			# user.should have(1).errors_on(:email)
		# end

		# it 'validates_format_of :email' do
		# end
	end
end
