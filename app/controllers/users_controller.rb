class UsersController < ApplicationController  
  
  before_filter :validate_username, :only => [:create]
  
  def new
    @user = User.new
  end
  
  def create     
    @user = User.new(params[:user])
    @user.save do |result|
      if result
        flash[:notice] = "Registration Successful!"
        redirect_to neighborhoods_path
      else
        render :action => :new
      end
    end
  end
  
  def validate_username
    if params[:user] && !VALID_USERS.include?(params[:user][:login].downcase)
      flash[:error] = "Can't register, user not on white list"
      redirect_to root_path
      return
    end
  end
end