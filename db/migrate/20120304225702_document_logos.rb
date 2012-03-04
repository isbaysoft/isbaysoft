class DocumentLogos < ActiveRecord::Migration
  def up
  	create_table 'document_logos' do |t|
			t.integer 'document_id', :null => false
	    t.integer 'logo_id', :null => false	   
			t.timestamps
  	end
  end

  def down
  	drop_table 'document_logos'
  end
end
