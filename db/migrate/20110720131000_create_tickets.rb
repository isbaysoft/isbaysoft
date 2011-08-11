class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string    'subject',  :limit => 60, :null => false
      t.text      'message',  :null => false
      t.text      'email'
      t.text      'name'
      t.string    'ip',       :limit => 15

      t.integer   'user_id',  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
