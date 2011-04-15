class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table 'users' do |t|
      t.string   'login',               :default => '',    :null => false
      t.string   'email',               :default => '',    :null => false
      t.string   'crypted_password',    :default => '',    :null => false
      t.string   'password_salt',       :default => '',    :null => false
      t.string   'persistence_token',   :default => '',    :null => false
      t.string   'single_access_token', :default => '',    :null => false
      t.string   'perishable_token',    :default => '',    :null => false
      t.integer  'login_count',         :default => 0,     :null => false
      t.integer  'failed_login_count',  :default => 0,     :null => false
      t.datetime 'last_request_at'
      t.datetime 'current_login_at'
      t.datetime 'last_login_at'
      t.string   'current_login_ip'
      t.string   'last_login_ip'
      t.integer  'usergroup_id',        :default => 2
      t.integer  'rule_id'
      t.boolean  'access',              :default => false
    end
  end

  def self.down
    drop_table 'users'
  end
end
