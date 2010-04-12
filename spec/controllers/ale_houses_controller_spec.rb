require 'spec_helper'

describe AleHousesController, "on GET to :new" do
  before :each do
    get :new, :neighborhood_id => Factory(:neighborhood).id
  end

  it "should assign to @house" do
    assigns[:house].should_not be_nil
  end

  it "should respond with success" do
    response.should be_success
  end
end

describe AleHousesController, "on GET to :index" do
  before :each do
    get :index, :neighborhood_id => Factory(:neighborhood).id
  end

  it "should respond with success" do
    response.should be_success
  end

  it "should assign to @houses" do
    assigns[:houses].should_not be_nil
  end
end

describe AleHousesController, "on good POST to :create" do
  before :each do
    @previous_count = AleHouse.count
    post :create, :ale_house => Factory.attributes_for(:ale_house), :neighborhood_id => Factory(:neighborhood).id
  end
  
  it "should respond with a redirect" do
    response.should be_redirect
  end
  
  it "should increase the number of Ale Houses by 1" do
    AleHouse.count.should == @previous_count + 1
  end
end

describe AleHousesController, "on bad POST to :create" do
  before :each do
    @previous_count = AleHouse.count
    post :create, :ale_house => Factory.attributes_for(:bad_ale_house), :neighborhood_id => Factory(:neighborhood).id
  end
  
  it "should respond with success" do
    response.should be_success
  end
  
  it "shouldn't change the number of Ale Houses" do
    AleHouse.count.should == @previous_count
  end
end

describe AleHousesController, "on GET to :show" do
  before :each do
    get :show, :id => Factory(:ale_house).id, :neighborhood_id => Factory(:neighborhood).id
  end
  
  it "should respond with success" do
    response.should be_success
  end
  
  it "should assign to the house var" do
    assigns[:ale_house].should_not be_nil
  end
end

describe AleHousesController, "on GET to :show with a bad id" do
  before :each do
    get :show, :id => -2, :neighborhood_id => Factory(:neighborhood).id
  end
  
  it "should redirect to the index page" do
    response.should redirect_to('neighborhoods')
  end
end

describe AleHousesController, "on GET to :edit with a good id" do
  before :each do 
    get :edit, :id => Factory(:ale_house).id, :neighborhood_id => Factory(:neighborhood).id
  end
  
  it "should respond with success" do
    response.should be_success
  end
  
  it "should assign to the ale_house var" do
    assigns[:ale_house].should_not be_nil
  end
end

describe AleHousesController, "on GET to :edit with a bad id" do
  before :each do
    get :edit, :id => -2, :neighborhood_id => Factory(:neighborhood).id
  end
  
  it "should redirect to index" do
    response.should redirect_to('neighborhoods')
  end
end