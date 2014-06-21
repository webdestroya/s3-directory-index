
class Settings
  def initialize
    Fog.credentials = { :path_style => true }
  end

  def source_prefix
    ENV['SOURCE_PREFIX'].chomp('/') + "/"
  end

  def dest_prefix
    ENV['DEST_PREFIX'].chomp('/') + "/"
  end

  def bucket
    ENV['S3_BUCKET']
  end

  def aws
    @aws ||= Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_access_key_id        => ENV['AWS_ACCESS_KEY'],
      :aws_secret_access_key    => ENV['AWS_SECRET_KEY']
    })
  end

  def [](key)
    @config[key]
  end

end