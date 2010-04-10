class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    if VALID_USERS.include?(params[:login])    
      @user = User.new(params[:user])
      @user.save do |result|
        if result
          flash[:notice] = "Registration Successful!"
          redirect_to neighborhood_index_path
        else
          render :action => :new
        end
      end
    else
      flash[:error] = "Cannot register, not on admin list"
      redirect_to root_path
    end
  end
end