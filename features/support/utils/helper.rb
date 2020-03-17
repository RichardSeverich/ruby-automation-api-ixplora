# This utility class will store data to be reused in the Step definitions.
class Helper
  def self.initialize
    @data = {}
  end

  def self.clear_data
    @data.clear
  end

  def self.add_data(key, content)
    @data.store(key, content)
  end

  def self.get_stored_value(key)
    return @data[key] if @data[key]
    {}
  end

  def self.get_stored_field(key, field)
    return @data[key][field] if @data[key][field]
    ''
  end

  def self.get_nested_field(key, field, sub_field)
    @data[key][field].first[sub_field]
  end

  def self.obtain_data
    @data
  end
end
