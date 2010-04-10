require 'find_or_redirect'

class AleHousesController < ApplicationController
  
  find_or_redirect :only => [:show, :destroy, :edit], :redirect_to => 'neighborhood_index_path'
  
  def index
    @houses = AleHouse.all
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def new
    @house = AleHouse.new
  end
  
  def create
    @house = AleHouse.new(params[:ale_house])
    if @house.save
      flash[:info] = "AleHouse Created"
      redirect_to neighborhood_index_path(@house.neighborhood)
    else      
      render :action => 'new'
    end
  end
end