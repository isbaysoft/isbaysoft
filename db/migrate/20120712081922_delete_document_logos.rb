class DeleteDocumentLogos < ActiveRecord::Migration
  def up
  	drop_table 'document_logos'
  end

  def down
		create_table "document_logos", :force => true do |t|
			t.integer  "document_id", :null => false
			t.integer  "logo_id",     :null => false
			t.datetime "created_at",  :null => false
			t.datetime "updated_at",  :null => false
		end
  end
end
