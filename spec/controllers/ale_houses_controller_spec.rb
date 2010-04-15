require 'spec_helper'

describe AleHousesController, "while logged in" do
  before do
    @controller.stub!(:current_user => User.new)
    @neighborhood = Factory(:neighborhood)
  end
  
  describe AleHousesController, "on GET to :new" do
    before :each do
      get :new, :neighborhood_id => @neighborhood.id
    end
    
    it "should respond with success" do
      response.should be_success
    end
    
    it "should assign to @house" do
      assigns[:house].should_not be_nil
    end
  end
  
  describe AleHousesController, "on GET to :index" do
    before :each do 
      get :index, :neighborhood_id => @neighborhood.id
    end
    
    it "should respond with success" do
      response.should be_success
    end
    
    it "should assign to @houses" do
      assigns[:houses].should_not be_nil
    end
  end
  
  describe AleHousesController, "on GET to :listing" do
    before :each do
      get :index, :neighborhood_id => @neighborhood.id
    end
    
    it "should respond with succes" do
      response.should be_success
    end
    
    it "should assign to @houses" do
      assigns[:houses].should_not be_nil
    end
  end
  
end

describe AleHousesController, "while not logged in" do
  describe AleHousesController, "on GET to :listing" do
    before :each do
      get :listing, :neighborhood_id => Factory(:neighborhood).id
    end
  
    it "should respond with success" do
      response.should be_success
    end
  end

  describe AleHousesController, "on GET to :new" do
    before :each do
      get :new, :neighborhood_id => Factory(:neighborhood).id
    end

    it "should respond with a redirect to the neighborhoods index" do
      response.should redirect_to(root_path)
    end
  end

  describe AleHousesController, "on GET to :index" do
    before :each do
      get :index, :neighborhood_id => Factory(:neighborhood).id
    end

    it "should redirect to the neighborhoods index" do
      response.should redirect_to(root_path)
    end
  end

  describe AleHousesController, "on good POST to :create" do
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

  describe AleHousesController, "on bad POST to :create" do
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

  describe AleHousesController, "on GET to :show" do
    before :each do
      get :show, :id => Factory(:ale_house).id, :neighborhood_id => Factory(:neighborhood).id
    end

    it "should respond with success" do
      response.should redirect_to(root_path)
    end
  end

  describe AleHousesController, "on GET to :show with a bad id" do
    before :each do
      get :show, :id => -2, :neighborhood_id => Factory(:neighborhood).id
    end

    it "should redirect to the index page" do
      response.should redirect_to(root_path)
    end
  end

  describe AleHousesController, "on GET to :edit with a good id" do
    before :each do 
      get :edit, :id => Factory(:ale_house).id, :neighborhood_id => Factory(:neighborhood).id
    end

    it "should respond with success" do
      response.should redirect_to(root_path)
    end
  end

  describe AleHousesController, "on GET to :edit with a bad id" do
    before :each do
      get :edit, :id => -2, :neighborhood_id => Factory(:neighborhood).id
    end

    it "should redirect to index" do
      response.should redirect_to(root_path)
    end
  end
end