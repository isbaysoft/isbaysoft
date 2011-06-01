class AlterDocumentsAddMenuId < ActiveRecord::Migration
  def self.up
    add_column 'documents', 'menu_id', :integer, :null => true
  end

  def self.down
    remove_column 'documents', 'menu_id'
  end
end
