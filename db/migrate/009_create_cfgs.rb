class CreateCfgs < ActiveRecord::Migration
  def self.up
    create_table 'cfgs' do |t|
      t.string   'name'
      t.string   'value'
      t.timestamps
    end
  end

  def self.down
    drop_table 'cfgs'
  end
end
