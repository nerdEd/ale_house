require 'oauth'
require 'authlogic_oauth'

class UserSession < Authlogic::Session::Base
  def self.oauth_consumer
    OAuth::Consumer.new("4N2YlI4nrZbK6uaX43WLdA", "L2w9kKl2mE7o8UNVCLb3wAFkFHH8TaKJXl7pnYkYMbs", {:site=>"http://twitter.com", :authorize_url => "http://twitter.com/oauth/authenticate" })
  end
end