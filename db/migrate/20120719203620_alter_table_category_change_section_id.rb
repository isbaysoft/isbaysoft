class AlterTableCategoryChangeSectionId < ActiveRecord::Migration
  def up
  	change_column 'categories', 'section_id', :integer, :null => false
  	change_column_default 'categories', 'section_id', nil
  end

  def down
  	change_column 'categories', 'section_id', :integer, :null => true, :default => 0
  end
end
