
class GeocodingController < ApplicationController
  
  def geocode()
    location = AddressGeocoder.get_location( params[:address] )
    render :json=>location.to_json()
  end

end
  
  