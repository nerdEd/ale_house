require 'find_or_redirect'

class NeighborhoodsController < ApplicationController

  before_filter :require_user, :except => [:index]

  find_or_redirect :only => [:edit, :show]
  
  def index
    @neighborhoods = Neighborhood.all
  end
  
  def show
    @neighborhood = Neighborhood.find(params[:id])
    render :json => @neighborhood.to_json
  end
  
  def new
    @neighborhood = Neighborhood.new
    render 'new'
  end
  
  def create
    @neighborhood = Neighborhood.new(params[:neighborhood])
    if @neighborhood.save
      flash[:info] = 'Neighborhood created.'
      redirect_to neighborhoods_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
end
