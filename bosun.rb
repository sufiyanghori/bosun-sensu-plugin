#!/opt/sensu/embedded/bin/ruby
require 'sensu-handler'
require 'uri'
require 'net/http'
require 'json'


class Show < Sensu::Handler
  def handle
    bosun_host = settings['bosun']['bosun_host']
    bosun_port = settings['bosun']['bosun_port']
    bosun_tags = settings['bosun']['bosun_tags']
   
    bosun_tags['host'] = @event['client']['name']

    bosun_uri = [ bosun_host, bosun_port ].join(':') + "/api/put"

    uri = URI.parse(bosun_uri)
    header = {'Content-Type': 'text/json'}
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)

    metrics = @event['check']['output']
    request.body = ""
    
    payload = Array.new   
    begin
      metrics.split("\n").each do |each_metric|
        (metric_name, metric_value, epoch_time) = each_metric.split(" ")        
        temp = Hash.new
        temp['metric'] = metric_name
        temp['timestamp'] = epoch_time.to_i
        temp['value'] = metric_value.to_i
        temp['tags'] = bosun_tags
        payload.push(temp)
      end
    end

    request.body = payload.to_json 
    response = http.request(request)    

  end
end
