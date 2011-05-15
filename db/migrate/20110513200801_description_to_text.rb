class DescriptionToText < ActiveRecord::Migration
  def self.up
    change_column :documents, 'description', :text
    change_column :categories, 'description', :text
    change_column :sections, 'description', :text
  end

  def self.down
  end
end
