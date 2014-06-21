class Folder

  def initialize(settings, name, fog_files)
    @settings = settings
    @fog_files = fog_files
    @name = name
  end

  def has_parent?
    @name != @settings.source_prefix
  end

  def name
    @name
  end

  def parent
    "/#{@settings.dest_prefix}#{File.dirname(@name)}/"
  end

  def folders
    @fog_files.common_prefixes.map {|f| File.basename(f) }
  end

  def files
    @fog_files.select{ |f| f.content_length > 1 }
  end

  def number_to_human_size(size)
    if size < 1024
      "#{size} Bytes"
    elsif size < 1024.0 * 1024.0
      "%.01f KB" % (size / 1024.0)
    elsif size < 1024.0 * 1024.0 * 1024.0
      "%.01f MB" % (size / 1024.0 / 1024.0)
    else
      "%.01f GB" % (size / 1024.0 / 1024.0 / 1024.0)
    end
  end



end