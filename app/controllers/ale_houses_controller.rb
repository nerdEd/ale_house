require 'find_or_redirect'

class AleHousesController < ApplicationController
  before_filter :require_user, :except => [:listing]
  
  find_or_redirect :only => [:show, :destroy, :edit], :redirect_to => 'neighborhoods_path'
  find_or_redirect :only => [:create, :index, :listing], 
                   :redirect_to => 'neighborhoods_path', 
                   :name => 'neighborhood',
                   :finder => 'Neighborhood.find_by_id(params[:neighborhood_id])'
  
  def index
    @houses = @neighborhood.ale_houses
  end
  
  def listing
    @houses = @neighborhood.ale_houses
    render :partial => 'list', :layout => false, :locals => {:houses => @houses}
  end
  
  def new
    @house = Neighborhood.new_ale_house(params[:neighborhood_id])
    render 'new'
  end
  
  def create
    params[:ale_house][:neighborhood_id] = @neighborhood.id
    @house = AleHouse.new(params[:ale_house])
    if @house.save
      flash[:info] = "AleHouse Created"
      redirect_to root_path
    else      
      render :action => 'new'
    end
  end

  def edit()
    @house = AleHouse.find_by_id(params[:id])
    render 'edit'
  end
  
  def update()
    house = AleHouse.find_by_id(params[:id])
    if house.update_attributes!(params[:ale_house]) then
      flash[:info] = 'Ale House updated.'
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def destroy()
    AleHouse.destroy(params[:id])
    redirect_to root_path
  end

end
