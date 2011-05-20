class CreateMenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.string    'title', :null => false, :limit => '250'
      t.string    'alias', :null => false, :limit => '250'
      t.string    'url', :null => false, :limit => '500'
      t.string    'note', :null => false, :limit => '500'
      t.boolean   'published', :null => false, :default => false
      t.integer   'access_level', :null => false
      t.boolean   'target'
      t.integer   'menu_id', :null => false
      t.integer   'order', :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_items
  end
end
