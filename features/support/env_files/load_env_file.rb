# This class loads the env file
class LoadEnvFile
  include Singleton
  def find_config_file(filename)
    root = Pathname.pwd
    until root.root?
      root.find do |path|
        return path.to_s if path.file? && path.basename.to_s == filename
      end
      root = root.parent
    end
    raise 'Configuration file '
  end

  def load_app_config_file(filename)
    config_file = find_config_file(filename)
    YAML.load_file(config_file)
  end
end
