# This module contains common methods to be used in the step definitions.
module CommonActions
  def self.built_data(input)
    param = input[/(?<=[{])[a-zA-Z_.]+(?=[}])/]
    if param
      param = param.split('.')
      value = if param.size > 2
                Helper.get_nested_field(param.shift, param.shift, param.shift)
              else
                Helper.get_stored_field(param.first, param.last)
              end
      input.sub!(/(?:[{])[a-zA-Z_.]+(?:[}])/, value)
    end
    input
  end

  def self.built_json(data)
    data.each do |key, value|
      data[key] = if value[/(?:[{])[a-zA-Z_.]+(?:[}])/]
                    CommonActions.built_data(value)
                  elsif Helper.get_stored_value(value).empty?
                    value[/[\d]+/] ? value.to_i : value
                  else
                    Helper.get_stored_value(value)
                  end
    end
  end

  def self.built_custom_json(json_string)
    loop do
      matches = json_string.scan(/(?:[{])[a-zA-Z_.]+(?:[}])/)
      break if matches.size.zero?
      json_string = json_string.sub(/(?:[<])(?:[{])[a-zA-Z_.]+(?:[}])(?:[>])/, built_data(matches.first))
    end
    json_string
  end
end
