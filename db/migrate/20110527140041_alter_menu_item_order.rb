class AlterMenuItemOrder < ActiveRecord::Migration
  def self.up
    rename_column 'menu_items', 'order', 'sort_no'
  end

  def self.down
    rename_column 'menu_items', 'sort_no', 'order'
  end
end
