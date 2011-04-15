class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table 'categories' do |t|
      t.string   'name'
      t.text     'description'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'section_id',  :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table 'categories'
  end
end
