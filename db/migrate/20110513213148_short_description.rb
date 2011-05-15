class ShortDescription < ActiveRecord::Migration
  def self.up
    add_column :documents, 'short_description', :text
    add_column :static_contents, 'short_description', :text
  end

  def self.down
    remove_column :documents, 'short_description'
    remove_column :static_contents, 'short_description'
  end
end
