require 'yaml'
require 'fog'
require 'slim'
require 'dotenv/tasks'
require './lib/settings.rb'
require './lib/folder.rb'

def recurse_folder(settings, bucket, folder)
  files = bucket.files.all(prefix: folder, delimiter: '/')

  folder_obj = Folder.new(settings, folder, files)

  tpl = Slim::Template.new('templates/layout.slim', {}).render(folder_obj)

  puts "Writing directory listing for #{folder} to #{settings.dest_prefix}#{folder} (#{tpl.size} bytes)"

  bucket.files.create(
    :key    => "#{settings.dest_prefix}#{folder}",
    :body   => tpl,
    :public => true
  )

  # RECURSE OTHERS

  files.common_prefixes.each do |prefix|
    recurse_folder(settings, bucket, prefix)
  end

end

task default: :info

desc "List settings"
task info: :dotenv do
  @settings = Settings.new

  puts "Source Prefix: #{@settings.source_prefix}"
  puts "Destination Prefix: #{@settings.dest_prefix}"
  puts "Bucket: #{@settings.bucket}"

end

desc "Updates the S3 Directory Indicies"
task update: :dotenv do

  @settings = Settings.new

  raise "Invalid Source" if "#{@settings.source_prefix}".size < 4
  raise "Invalid Destination" if "#{@settings.dest_prefix}".size < 4

  bucket = @settings.aws.directories.get(@settings.bucket)
  recurse_folder(@settings, bucket, @settings.source_prefix)

end # /update_task