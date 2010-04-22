class ApplicationController < ActionController::Base
  has_mobile_fu
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
end
