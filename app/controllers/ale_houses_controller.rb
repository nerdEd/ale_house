require 'find_or_redirect'

class AleHousesController < ApplicationController
  before_filter :require_user, :except => [:listing]
  
  find_or_redirect :only => [:show, :destroy, :edit], :redirect_to => 'neighborhoods_path'
  find_or_redirect :only => [:create, :index, :listing], 
                   :redirect_to => 'neighborhoods_path', 
                   :name => 'neighborhood',
                   :finder => 'Neighborhood.find_by_id(params[:neighborhood_id])'
  
  def index
    
  end
  
  def listing
    @houses = @neighborhood.ale_houses
    render :partial => 'list', :layout => false, :locals => {:houses => @houses}
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def new
    @house = AleHouse.new
  end
  
  def create
    params[:ale_house][:neighborhood_id] = @neighborhood.id
    @house = AleHouse.new(params[:ale_house])
    if @house.save
      flash[:info] = "AleHouse Created"
      redirect_to neighborhood_path(@house.neighborhood)
    else      
      render :action => 'new'
    end
  end
end