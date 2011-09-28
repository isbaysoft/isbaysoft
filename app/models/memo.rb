class Memo < ActiveRecord::Base

  scope :get, lambda { |identify| { :conditions => ['identify = ?',identify] } }

  def self.get_memo (identify)
    memo = get(identify).first
    memo.present? ? memo.memo : ''
  end

  # Method _write_ store value to memo table.
  def self.write(identify,value)
    if exists?(['identify = ?',identify])
      memo = find_by_identify(identify)
      memo.update_attributes({:memo => value})
      memo.save
    else
      memo = new({:identify => identify, :memo => value})
      memo.save
    end
  end

  # Method _read_ read value from memo table.
  # If param name not found, will be created new record with neme _identify_ and return it.
  def self.read(identify,def_value)
    if exists?(['identify = ?',identify])
      memo = find_by_identify(identify)
      memo = create( :identify => identify, :value => def_value ) unless memo && def_value.nil?
    end
    memo
  end
  
end
