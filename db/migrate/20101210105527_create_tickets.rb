class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table  'ticket_subjects' do |t|
      t.string    'subject'
      t.integer   'user_id'
      t.integer   'state', :default => 0
      t.string    'email'
      t.integer   'responsed', :default => 0
      t.timestamps
    end
    create_table  'ticket_messages' do |t|
      t.integer   'ticket_subject_id', :default => 0
      t.string    'message', :limit => 250
      t.integer   'atype', :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table 'ticket_subjects'
    drop_table 'ticket_messages'
  end
end
