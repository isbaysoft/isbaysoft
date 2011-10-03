require 'spec_helper'

describe 'User Model' do
	describe 'association' do
		it 'belongs_to rule' do
			user = Factory(:users)
		end
	end
end
