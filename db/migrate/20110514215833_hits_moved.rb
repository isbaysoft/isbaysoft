class HitsMoved < ActiveRecord::Migration
  def self.up
    remove_column :documents, 'hits'
    add_column :document_files, 'hits', :integer, :default => 0
  end

  def self.down
    remove_column :document_files, 'hits'
    add_column :documents, 'hits', :integer, :default => 0
  end
end
