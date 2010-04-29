require 'httpclient'

class GeocodingController<ApplicationController
  
  def geocode()
    clnt = HTTPClient.new
    content = clnt.get_content(
      "http://maps.google.com/maps/api/geocode/json?sensor=false&address=734+s+broadway,baltimore,md")
    render :json=>content

  end
  
end
  
  