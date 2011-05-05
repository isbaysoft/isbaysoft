class CreateLogos < ActiveRecord::Migration
  def self.up
    create_table :logos do |t|
      t.string   'logo_file_name'
      t.string   'logo_content_type'
      t.integer  'logo_file_size'
      t.datetime 'logo_updated_at'
    end
  end

  def self.down
    drop_table :logos
  end
end
