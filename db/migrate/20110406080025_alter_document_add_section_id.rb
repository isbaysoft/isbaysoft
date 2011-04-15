class AlterDocumentAddSectionId < ActiveRecord::Migration
  def self.up
    add_column :documents, 'section_id', :integer
  end

  def self.down
    remove_column 'documents', 'section_id'
  end
end
