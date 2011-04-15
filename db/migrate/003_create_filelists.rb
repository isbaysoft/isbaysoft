class CreateFilelists < ActiveRecord::Migration
  def self.up
    create_table 'filelists' do |t|
      t.string   'f_file_name'
      t.string   'f_content_type'
      t.integer  'f_file_size'
      t.datetime 'f_updated_at'
      t.timestamps
    end
  end

  def self.down
    drop_table 'filelists'
  end
end
