require 'find_or_redirect'

class NeighborhoodsController < ApplicationController

  find_or_redirect :only => [:edit, :show]
  
  def index
    @neighborhoods = Neighborhood.all
  end
  
  def show
    
  end
  
  def new
    @neighborhood = Neighborhood.new
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