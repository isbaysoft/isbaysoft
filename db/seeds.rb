# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

#  CREATE ROLES
#Delete all rules
Rule.destroy_all

#Create Role for Super Administrator
rule = Rule.new :name => 'Super Administrator'
rule.access_level = 1000
rule.save

#Create Role for Administrator
rule = Rule.new :name => 'Administrator'
rule.access_level = 900
rule.save

#Create Role for Moderator
rule = Rule.new :name => 'Moderator'
rule.access_level = 800
rule.save

#Create Role for Member
rule = Rule.new :name => 'Member'
rule.access_level = 700
rule.save

#Create Role for Everybody
rule = Rule.new :name => 'Everybody'
rule.access_level = 0
rule.save
