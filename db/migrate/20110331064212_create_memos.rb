class CreateMemos < ActiveRecord::Migration
  def self.up
    create_table :memos do |t|
      t.text 'memo'
      t.integer 'object_id'
      t.string 'identify'
      
      t.timestamps
    end
  end

  def self.down
    drop_table :memos
  end
end
