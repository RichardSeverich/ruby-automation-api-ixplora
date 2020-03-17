# Manage the conversion of hashes and string to json
module ResponseBuilder
  def self.parse_file(filename)
    base_path = File.dirname(__FILE__)
    path = "#{base_path}/../json_templates/#{filename}.json"
    file = File.read(path)
    @template = JSON.parse(file)
    @copy = @template.is_a?(Hash) ? Hash[@template] : [].replace(@template)
  end

  def self.build_response(filename, request, response)
    parse_file(filename)
    request = JSON.parse(request)
    response = JSON.parse(response)
    @template = @template.is_a?(Hash) ? build_with_hash(request, @template) : build_with_array(request, @template)
    @template = @template.is_a?(Hash) ? build_with_hash(response, @template) : build_with_array(response, @template)
  end

  def self.build_with_hash(modifier, template)
    template.each_key do |key|
      if template[key].is_a?(Hash)
        template[key] = build_with_hash(modifier[key], template[key])
      elsif template[key].is_a?(Array)
        template[key] = build_with_array(modifier[key], template[key])
      elsif template[key] != modifier[key]
        template[key] = modifier[key]
      end
    end
    template
  end

  def self.build_with_array(modifier, template)
    template.each_with_index do |val, index|
      if val.is_a?(Hash)
        template[index] = build_with_hash(modifier[index], template[index])
      elsif val.is_a?(Array)
        template[index] = build_with_array(modifier[index], template[index])
      elsif val != modifier[index]
        template[index] = modifier[index]
      end
    end
    template
  end
end
