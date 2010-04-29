require 'httpclient'
require 'uri'
require 'json'
require 'PP'
class GeocodingController<ApplicationController
  
  def geocode()
    address=URI.escape(params[:address] ) 
    
    clnt = HTTPClient.new
    content = clnt.get_content(
      "http://maps.google.com/maps/api/geocode/json?sensor=false&address=#{address }")
    content=JSON.parse(content)['results'][0]['geometry']['location'].to_json()
    render :json=>content

  end
  
end
  
  