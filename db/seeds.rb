# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Rule.create(:name => 'Super Administrator', :access_level => 1000)
Rule.create(:name => 'Administrator', :access_level => 900)
Rule.create(:name => 'Moderator', :access_level => 800)
Rule.create(:name => 'Member', :access_level => 700)
Rule.create(:name => 'Everybody', :access_level => 0)