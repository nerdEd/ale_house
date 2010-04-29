require 'httpclient'
require 'uri'
require 'json'

class GeocodingController < ApplicationController
  
  def geocode()
    address=prepare_address() 
    content = call_geocode_service(address)
    result= produce_result(content)
    render :json=>result.to_json()
  end

  private
    def prepare_address(address=params[:address])
      URI.escape("#{address},baltimore,md") 
    end

    def call_geocode_service(address)
      url="http://maps.google.com/maps/api/geocode/json?sensor=false&address=#{address }"
      HTTPClient.new.get_content(url)
    end
  
    def produce_result(content)
      entry = JSON.parse(content)['results'][0]
      entry['geometry']['location'].merge('address'=>entry['formatted_address'])
    end

end
  
  