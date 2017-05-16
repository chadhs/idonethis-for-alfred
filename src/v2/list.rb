# I Done This for Alfred
## instructions here: https://github.com/chadhs/idonethis-for-alfred
## need help? drop me a line.
## hello@chadstovern.com or @chadhs

require 'net/http'
require 'net/https'
require 'json'
require 'date'
require 'digest/md5'
require 'fileutils'

# A file-based caching library. It uses Marshal::dump and Marshal::load
# to serialize/deserialize cache values - so you should be OK to cache
# object values.
class FileCache
  MAX_DEPTH = 32

  # Create a new reference to a file cache system.
  # root_dir:: The root directory of the cache file hierarchy
  #            The cache will be rooted at root_dir/
  # expiry:: The expiry time for cache entries, in seconds. Use
  #          0 if you want cached values never to expire.
  # depth:: The depth of the file tree storing the cache. Should
  #         be large enough that no cache directory has more than
  #         a couple of hundred objects in it
  def initialize(root_dir = '/tmp/default', expiry = 0, depth = 2)
    @root_dir = root_dir
    @expiry   = expiry
    @depth    = depth > MAX_DEPTH ? MAX_DEPTH : depth

    FileUtils.mkdir_p @root_dir
  end

  # Set a cache value for the given key. If the cache contains an existing value for
  # the key it will be overwritten.
  def set(key, value)
    f = File.open(get_path(key), 'w')
    Marshal.dump(value, f)
    f.close
  end

  # Return the value for the specified key from the cache. Returns nil if
  # the value isn't found.
  def get(key)
    path = get_path(key)

    # expire
    if @expiry > 0 && File.exist?(path) && Time.new - File.new(path).mtime >= @expiry
      FileUtils.rm path
    end

    if File.exist? path
      f = File.open path, 'r'
      result = Marshal.load f
      f.close

      result
    end
  end

  # Return the value for the specified key from the cache if the key exists in the
  # cache, otherwise set the value returned by the block. Returns the value if found
  # or the value from calling the block that was set.
  def get_or_set(key)
    value = get key
    return value if value
    value = yield
    set key, value
    value
  end

  # Delete the value for the given key from the cache
  def delete(key)
    FileUtils.rm(get_path(key))
  end

  # Delete ALL data from the cache, regardless of expiry time
  def clear
    return unless File.exist? @root_dir

    FileUtils.rm_r @root_dir
    FileUtils.mkdir_p @root_dir
  end

  # Delete all expired data from the cache
  def purge
    @t_purge = Time.new
    purge_dir @root_dir if @expiry > 0
  end

  #-------- private methods ---------------------------------
  private

  def get_path(key)
    md5 = Digest::MD5.hexdigest(key.to_s).to_s

    dir = File.join(@root_dir, md5.split(//)[0..@depth - 1])
    FileUtils.mkdir_p dir
    File.join dir, md5
  end

  def purge_dir(dir)
    Dir.foreach dir do |f|
      next if f =~ /^\.\.?$/
      path = File.join(dir, f)
      if File.directory? path
        purge_dir path
      elsif @t_purge - File.new(path).mtime >= @expiry
        # Ignore files starting with . - we didn't create those
        next if f =~ /^\./
        FileUtils.rm path
      end
    end

    # Delete empty directories
    return unless Dir.entries(dir).delete_if { |e| e =~ /^\.\.?$/ }.empty?
    Dir.delete(dir)
  end
end

api_token   = ENV['api_token']
team_id     = ENV['team_id']
api_version = 'v2'
base_uri    = "https://beta.idonethis.com/api/#{api_version}"

## get & output the list of entries
print begin
  cache = FileCache.new ENV['alfred_workflow_cache'], 300

  list_cache = cache.get 'list'

  if list_cache.nil?
    uri = URI "#{base_uri}/teams/#{team_id}/entries"

    # Create client
    http             = Net::HTTP.new uri.host, uri.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Create Request
    req = Net::HTTP::Get.new uri

    # Add headers
    req.add_field 'Authorization', "Token #{api_token}"

    # Fetch Request
    res = http.request req

    json_res_body = if res.code == '200'
                      JSON.parse res.body
                    else
                      [
                        {
                          'body'   => "Something went wrong: #{res.body}",
                          'status' => "HTTP status: #{res.code}"
                        }
                      ]
                    end

    formatted_for_alfred = {
      'items' => []
    }

    json_res_body.each do |entry|
      formatted_for_alfred['items'] << {
        'title'    => entry['body'],
        'subtitle' => 'Mark as done',
        'arg'      => entry['hash_id'],
        'valid'    => (entry['status'] == 'goal' ? true : false),
      } if entry['status'] == 'goal' && entry['completed_on'].nil?
    end

    # Show a nice message if no goals are returned
    if formatted_for_alfred.empty?
      formatted_for_alfred['items'] << {
        'title'    => 'No goals set!',
        'subtitle' => 'Looks like you should set some goals',
        'valid'    => false,
      }
    else
      list = formatted_for_alfred.to_json

      # Cache the reponse for 5 minutes
      cache.set 'list', list

      list
    end
  else
    list_cache
  end
rescue StandardError => e
  {
    'items' => [
      {
        'title'    => 'Error',
        'subtitle' => e.message,
      }
    ]
  }.to_json
end
