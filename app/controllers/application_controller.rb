class ApplicationController < ActionController::Base
  has_mobile_fu
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def current_user
    session[:user]
  end

  private 

    def require_user
      return session[:user]
    end

    def require_no_user
      return !session[:user]
    end
end
