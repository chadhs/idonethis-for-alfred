# I Done This for Alfred
## instructions here: https://github.com/chadhs/idonethis-for-alfred
## need help? drop me a line.
## hello@chadstovern.com or @chadhs

require 'net/http'
require 'net/https'
require 'json'
require 'date'

api_token   = ENV['api_token']
team_id     = ENV['team_id']
api_version = 'v2'
base_uri    = "https://beta.idonethis.com/api/#{api_version}"

## get & output the list of entries
print begin
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
      'valid'    => (entry['status'] == 'goal' ? true : false)
    } if entry['status'] == 'goal' && entry['completed_on'].nil?
  end

  formatted_for_alfred.to_json
rescue StandardError => e
  [
    {
      'body'   => "HTTP request failed: #{e.message}",
      'status' => 'Error'
    }
  ]
end
