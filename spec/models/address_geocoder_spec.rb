require 'spec_helper'

describe AddressGeocoder do
  context '#get_location' do
    
    before(:all) do
      #http://code.google.com/apis/maps/documentation/geocoding/#JSON
      @location_data=
          {'results'=>
            [
              {'formatted_address'=>'formatted address',
                'geometry'=>{'location'=>{'lat'=>1,'lng'=>2}},
                'other elements'=>'that we are not interested in'
              }
            ]
          }.to_json()
    end
    
    before(:each) do   
      @service_client = HTTPClient.new
      @service_client.stub!(:get_content).and_return(@location_data)
      @address_geocoder=AddressGeocoder.new('734 South Broadway', @service_client)
    end
    
    it 'should call the geocoding service' do
      @service_client.should_receive(:get_content).once().and_return(@location_data)
      @address_geocoder.get_location()
    end
    
    it 'should return the latitude, longitude and the formatted address' do
      @address_geocoder.get_location().should == {'lat'=>1,'lng'=>2,'address'=>'formatted address'}
    end
    
    it 'should escape the address being embedded into the request url' do
      URI.should_receive(:escape).once().with(/^734 South Broadway/)
      @address_geocoder.get_location()
    end
  
  end

end