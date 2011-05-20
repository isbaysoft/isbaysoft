class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.string    'title', :null => false
      t.integer   'menu_id'
      t.boolean   'published', :null => false, :default => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :menus
  end
end
