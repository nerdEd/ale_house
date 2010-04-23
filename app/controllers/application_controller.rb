class ApplicationController < ActionController::Base
  has_mobile_fu

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :find_user

  def find_user
    @current_user = current_user
  end

  private 
    def current_user
      session[:user]
    end

    def require_user
      return session[:user]
    end

    def require_no_user
      return !session[:user]
    end
end
