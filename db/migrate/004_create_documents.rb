class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table 'documents' do |t|
      t.string   'name'
      t.integer  'filelist_id'
      t.integer  'category_id'
      t.boolean  'published',    :default => false
      t.boolean  'approved',     :default => false
      t.integer  'hits',         :default => 0
      t.string   'description'
      t.integer  'access_level'
      t.timestamps
    end
  end

  def self.down
    drop_table 'documents'
  end
end
