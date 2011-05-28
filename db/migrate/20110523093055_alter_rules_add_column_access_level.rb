class AlterRulesAddColumnAccessLevel < ActiveRecord::Migration
  def self.up
    add_column :rules, 'access_level', :integer, :null => false
  end

  def self.down
    remove_columns :rules, 'access_level'
  end
end
