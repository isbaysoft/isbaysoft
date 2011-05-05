class DocAddLogo < ActiveRecord::Migration
  def self.up
    add_column :documents, 'logo_id', :integer, :null => true
  end

  def self.down
    remove_column :documents, 'logo_id'
  end
end
