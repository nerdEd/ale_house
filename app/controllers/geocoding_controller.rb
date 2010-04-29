require 'httpclient'
require 'uri'
require 'json'
require 'PP'

class GeocodingController<ApplicationController
  
  def geocode()
    
    address=URI.escape("#{params[:address]},baltimore,md" ) 
    
    clnt = HTTPClient.new
    content = clnt.get_content(
      "http://maps.google.com/maps/api/geocode/json?sensor=false&address=#{address }")
    entry = JSON.parse(content)['results'][0]
    result= entry['geometry']['location'].merge('address'=>entry['formatted_address'])
    render :json=>result.to_json()

  end
  
end
  
  