class AlterUsersAccessLevel < ActiveRecord::Migration
  def self.up
    add_column 'users', 'access_level', :integer
    remove_column 'users', 'rule_id'
  end

  def self.down
    remove_column 'users', 'access_level'
    add_column 'users', 'rule_id', :integer
  end
end
