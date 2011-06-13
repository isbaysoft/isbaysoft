class CreateScreenshots < ActiveRecord::Migration
  def self.up
    create_table :screenshots do |t|
      t.string   'screenshot_file_name'
      t.string   'screenshot_content_type'
      t.integer  'screenshot_file_size'
      t.datetime 'screenshot_updated_at'
      t.integer  'document_id'
      t.string   'short_description'
      t.text     'description', :limit => 250

      t.timestamps
    end
  end

  def self.down
    drop_table :screenshots
  end
end
