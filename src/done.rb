# I Done This for Alfred
## instructions here: https://github.com/chadhs/idonethis-for-alfred
## need help? drop me a line.
## hello@chadstovern.com or @chadhs

require 'net/http'
require 'net/https'
require 'json'
require 'date'

## static values
done_date   = Date.today.strftime '%Y-%m-%d'
api_token   = ENV['api_token']
api_version = 'v2'
base_uri    = "https://beta.idonethis.com/api/#{api_version}"

## Update your goal to done
begin
  uri = URI "#{base_uri}/entries/#{ARGV[0]}"

  # Create client
  http             = Net::HTTP.new uri.host, uri.port
  http.use_ssl     = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Create Request
  req = Net::HTTP::Put.new uri
  # Auth w/ your API token
  req.add_field 'Authorization', "Token #{api_token}"
  # Set encoding
  req.add_field 'Content-Type', 'application/json; charset=utf-8'
  # Set header and body
  req.body = JSON.dump 'status'      => 'done',
                       'occurred_on' => done_date

  # Fetch Request
  res = http.request req

  if res.code == '200'
    print 'Your goal is done!'
  else
    puts "HTTP Status Code: #{res.code}"
    puts "HTTP Response Body: #{res.body}"
    puts 'RUH ROH! Your goal was not updated.'
  end
rescue StandardError => e
  puts "HTTP Request failed (#{e.message})"
end
