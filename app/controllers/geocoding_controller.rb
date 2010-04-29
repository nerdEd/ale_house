require 'httpclient'
require 'uri'

class GeocodingController<ApplicationController
  
  def geocode()
    address=URI.escape(params[:address] ) 
    
    clnt = HTTPClient.new
    content = clnt.get_content(
      "http://maps.google.com/maps/api/geocode/json?sensor=false&address=#{address }")
    render :json=>content

  end
  
end
  
  