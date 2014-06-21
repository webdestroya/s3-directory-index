
class Settings
  def initialize
    @config = YAML.load(File.read("config.yml"))
  end

  def [](key)
    @config[key]
  end

end