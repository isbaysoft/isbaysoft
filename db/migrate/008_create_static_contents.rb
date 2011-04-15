class CreateStaticContents < ActiveRecord::Migration
  def self.up
    create_table 'static_contents' do |t|
      t.string   'name'
      t.text     'content'
      t.string   'position'
      t.integer  'user_id'
      t.timestamps
    end
  end

  def self.down
    drop_table 'static_contents'
  end
end
