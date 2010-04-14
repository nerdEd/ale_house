require 'spec_helper'

describe AleHousesController, "on GET to :listing while not logged in" do
  before :each do
    get :listing, :neighborhood_id => Factory(:neighborhood).id
  end
  
  it "should respond with success" do
    response.should be_success
  end
end

describe AleHousesController, "on GET to :new while not logged in" do
  before :each do
    get :new, :neighborhood_id => Factory(:neighborhood).id
  end

  it "should respond with a redirect to the neighborhoods index" do
    response.should redirect_to(root_path)
  end
end

describe AleHousesController, "on GET to :index while not logged in" do
  before :each do
    get :index, :neighborhood_id => Factory(:neighborhood).id
  end

  it "should redirect to the neighborhoods index" do
    response.should redirect_to(root_path)
  end
end

describe AleHousesController, "on good POST to :create while not logged in" do
  before :each do
    @previous_count = AleHouse.count
    post :create, :ale_house => Factory.attributes_for(:ale_house), :neighborhood_id => Factory(:neighborhood).id
  end

  it "should respond with a redirect to the neighborhoods index" do
    response.should redirect_to(root_path)
  end
  
  it "should not change the ale house count" do
    @previous_count.should == AleHouse.count
  end
end

describe AleHousesController, "on bad POST to :create while not logged in" do
  before :each do
    @previous_count = AleHouse.count
    post :create, :ale_house => Factory.attributes_for(:bad_ale_house), :neighborhood_id => Factory(:neighborhood).id
  end

  it "should respond with success" do
    response.should redirect_to(root_path)
  end

  it "shouldn't change the number of Ale Houses" do
    AleHouse.count.should == @previous_count
  end
end

describe AleHousesController, "on GET to :show while not logged in" do
  before :each do
    get :show, :id => Factory(:ale_house).id, :neighborhood_id => Factory(:neighborhood).id
  end

  it "should respond with success" do
    response.should redirect_to(root_path)
  end
end

describe AleHousesController, "on GET to :show with a bad id while not logged in" do
  before :each do
    get :show, :id => -2, :neighborhood_id => Factory(:neighborhood).id
  end

  it "should redirect to the index page" do
    response.should redirect_to(root_path)
  end
end

describe AleHousesController, "on GET to :edit with a good id while not logged in" do
  before :each do 
    get :edit, :id => Factory(:ale_house).id, :neighborhood_id => Factory(:neighborhood).id
  end

  it "should respond with success" do
    response.should redirect_to(root_path)
  end
end

describe AleHousesController, "on GET to :edit with a bad id while not logged in" do
  before :each do
    get :edit, :id => -2, :neighborhood_id => Factory(:neighborhood).id
  end

  it "should redirect to index" do
    response.should redirect_to(root_path)
  end
end