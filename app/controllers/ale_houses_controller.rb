require 'find_or_redirect'

class AleHousesController < ApplicationController
  before_filter :require_user, :except => [:listing]
  
  find_or_redirect :except => [:index, :new, :listing, :create], :redirect_to => 'neighborhoods_path'
  find_or_redirect :only => [:create, :index, :like, :listing], 
                   :redirect_to => 'neighborhoods_path', 
                   :name => 'neighborhood',
                   :finder => 'Neighborhood.find_by_id(params[:neighborhood_id])'
  
  def index
    @houses = @neighborhood.ale_houses
  end
  
  def like
    if like = Like.find_by_ale_house_id_and_created_by(params[:id], session[:user]['screen_name'])
      like.destroy
    else
      Like.create(:ale_house_id => params[:id], :created_by => session[:user]['screen_name'])
    end
    redirect_to root_path(:anchor => @neighborhood.name.parameterize)
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
    @house = create_new_ale_house()
    if @house.save
      flash[:info] = "AleHouse Created"
      redirect_to root_path + "##{@house.neighborhood.id}"
    else      
      render :action => 'new'
    end
  end

  def edit()
    @house = AleHouse.find_by_id(params[:id])
    render 'edit'
  end
  
  def update()
    if @ale_house.update_attributes!(params[:ale_house]) then
      flash[:info] = 'Ale House updated.'
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def destroy()
    AleHouse.destroy(@ale_house.id)
    redirect_to root_path
  end

  private
    def create_new_ale_house()
      AleHouse.new(params[:ale_house]) do |ale_house|
        ale_house.neighborhood_id= @neighborhood.id
        ale_house.created_by= current_user_name()
      end
    end
end

