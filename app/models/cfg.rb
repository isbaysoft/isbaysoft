class Cfg < ActiveRecord::Base

  def self.getvalue(name)
    v = Cfg.find_by_name(name)
    v.value if v
  end

  # Store configuration from Hash
  def self.save_config(hash_values)
    hash_values.each_pair { |key,value| write(key, value) }
  end

  # Method _read_ read value from config table.
  # If param name not found, will be created new record with neme _name_ and return it.
  def self.read(name,def_value)
    @value = find_all_by_name(name).first
    @value = create( :name => name, :value => def_value ) unless @value
    return @value.value
  end

  # Method _write_ store value to config table.
  def self.write(name,value)
    @value =  find_all_by_name(name).first
    if @value
      @value.update_attributes({:value => value})
      @value.save 
    else      
      @value = create( :name => name, :value => value ) 
    end
  end

end