class CreateDocumentFiles < ActiveRecord::Migration
  def self.up
    create_table 'document_files' do |t|
      t.integer 'document_id', :null => false
      t.integer 'filelist_id', :null => false
     
      t.timestamps
    end
    
    remove_column 'documents', 'filelist_id'
  end

  def self.down
    drop_table 'document_files'
    add_column 'documents', 'filelist_id', :integer
  end
end
