require 'faraday'
require 'yaml'

CONFIG = YAML.load_file(File.join(__dir__, '../config/application.yml'))

def base_connection
  Faraday::Connection.new(
    url: "https://#{CONFIG['local_bridge_ip']}/clip/v2/resource",
    ssl: {
      # ca_file: './config/huebridge_cacert_bundle.pem',
      verify: false
    }
  ) do |req|
    req.headers['hue-application-key'] = CONFIG['app_key']
  end
end

def turn_light_on(connection)
  connection.put "light/#{CONFIG['light_rid']}" do |req|
    req.body = JSON.generate(
      {
        "on": { "on": true },
        "dimming": { "brightness": 50 },
        "color": { "xy": { "x": 0.175, "y": 0.000 } }
      }
    )
  end
end

def turn_light_off(connection)
  connection.put "light/#{CONFIG['light_rid']}" do |req|
    req.body = JSON.generate({ "on": { "on": false } })
  end
end

def sensor_status(connection)
  response = connection.get "contact/#{CONFIG['sensor_rid']}"
  parsed_response = JSON.parse(response.body, symbolize_names: true)
  parsed_response[:data][0][:contact_report][:state]
end

connection = base_connection

previous_status = ''

loop do
  while sensor_status(connection) == previous_status
    sleep 2
  end

  current_status = sensor_status(connection)

  case current_status
  when 'no_contact'
    turn_light_off(connection)
    puts 'Contact is open.'
  when 'contact'
    turn_light_on(connection)
    puts "Contact is closed."
  end
  previous_status = current_status
end
