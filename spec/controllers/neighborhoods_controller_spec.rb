require 'spec_helper'

describe NeighborhoodsController, "on GET to :new" do
  before :each do
    get :new
  end

  it "should assign to neighborhood" do
    assigns[:neighborhood].should_not be_nil
  end

  it "should respond with success" do
    response.should be_success
  end
end

describe NeighborhoodsController, "on GET to :index" do
  before :each do
    get :index
  end

  it "should respond with success" do
    response.should be_success
  end

  it "should assign to neighborhoods" do
    assigns[:neighborhoods].should_not be_nil
  end
end

describe NeighborhoodsController, "on good POST to :create" do
  before :each do
    @previous_count = Neighborhood.count
    post :create, :neighborhood => Factory.attributes_for(:neighborhood)
  end
  
  it "should respond with a redirect" do
    response.should be_redirect
  end
  
  it "should increase the number of Neighborhoods by 1" do
    Neighborhood.count.should == @previous_count + 1
  end
end

describe NeighborhoodsController, "on bad POST to :create" do
  before :each do
    @previous_count = Neighborhood.count
    post :create, :neighborhood => Factory.attributes_for(:bad_neighborhood)
  end
  
  it "should respond with success" do
    response.should be_success
  end
  
  it "shouldn't change the number of Neighborhoods" do
    Neighborhood.count.should == @previous_count
  end
end

describe NeighborhoodsController, "on GET to :show" do
  before :each do
    get :show, :id => Factory(:neighborhood).id
  end
  
  it "should respond with success" do
    response.should be_success
  end
  
  it "should assign to the neighborhood var" do
    assigns[:neighborhood].should_not be_nil
  end
end

describe NeighborhoodsController, "on GET to :show with a bad id" do
  before :each do
    get :show, :id => -2
  end
  
  it "should redirect to the index page" do
    response.should redirect_to(:action => 'index')
  end
end

describe NeighborhoodsController, "on GET to :edit with a good id" do
  before :each do 
    get :edit, :id => Factory(:neighborhood).id
  end
  
  it "should respond with success" do
    response.should be_success
  end
  
  it "should assign to the neighborhood var" do
    assigns[:neighborhood].should_not be_nil
  end
end

describe NeighborhoodsController, "on GET to :edit with a bad id" do
  before :each do
    get :edit, :id => -2
  end
  
  it "should redirect to index" do
    response.should redirect_to(:action => 'index')
  end
end