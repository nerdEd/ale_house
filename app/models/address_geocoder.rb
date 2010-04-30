require 'httpclient'
require 'uri'
require 'json'

class AddressGeocoder

  def self.get_location(address)
    self.new(address).get_location()
  end
  
  def initialize(address)
    @address = address.to_s()
  end
  
  def get_location(address=@address)
    url = prepare_url(address) 
    location_data = call_location_service(url)
    produce_result(location_data)
  end
  
  private 
    def prepare_url(address)
      "http://maps.google.com/maps/api/geocode/json?sensor=false&address=#{escape_address(address)}"
    end

    def call_location_service(url)
      HTTPClient.new.get_content(url)
    end

    def produce_result(location_data)
      entry= JSON.parse(location_data)['results'][0]
      entry['geometry']['location'].merge('address'=>entry['formatted_address'])
    end

    def escape_address(address=@address)
      URI.escape("#{address},baltimore,md") 
    end
    
end