require 'spec_helper'
require 'auth_spec_helper'

describe AleHousesController, "I'm sorry Ed" do
  it "... seriously" do
    neighborhood = Factory(:neighborhood)
    ale_house_2 = Factory(:zerthas, :neighborhood => neighborhood)
    ale_house = Factory(:ale_house, :neighborhood => neighborhood)
    get :listing, :neighborhood_id => neighborhood.id
    assigns[:houses].should == [ale_house, ale_house_2]
    assigns[:houses].should_not == [ale_house_2, ale_house]
  end
end

describe AleHousesController, "on GET to :listing" do
  before :each do
    get :listing, :neighborhood_id => Factory(:neighborhood).id
  end

  it "should respond with success" do
    response.should be_success
  end
end

describe "with a logged in user" do
  before :each do
    login 
  end

  describe AleHousesController, "on GET to :new" do
    integrate_views

    before :each do
      get :new, :neighborhood_id => Factory(:neighborhood).id
    end

    it "should respond with success" do
      response.should be_success
    end
  end

  describe AleHousesController, "on good POST to :create" do
    before :each do
      login 
      @previous_count = AleHouse.count
      post :create, :ale_house => Factory.attributes_for(:ale_house), :neighborhood_id => Factory(:neighborhood).id
    end

    it "should redirect" do
      response.should be_redirect
    end

    it "should change the alehouse count" do
      AleHouse.count.should == @previous_count + 1
    end
  end

  describe AleHousesController, "on bad POST to :create" do
    before :each do
      session[:user]= {'screen_name'=>'jesse watts'}
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

  describe AleHousesController, "on GET to :show with a bad id" do
    before :each do
      get :show, :id => -2, :neighborhood_id => Factory(:neighborhood).id
    end

    it "should redirect to the index page" do
      response.should redirect_to('/neighborhoods')
    end
  end

  describe AleHousesController, "on GET to :edit with a good id" do
    before :each do 
      get :edit, :id => Factory(:ale_house).id, :neighborhood_id => Factory(:neighborhood).id
    end

    it "should respond with success" do
      response.should be_success
    end
  end

  describe AleHousesController, "on GET to :edit with a bad id" do
    before :each do
      get :edit, :id => -2, :neighborhood_id => Factory(:neighborhood).id
    end

    it "should redirect to index" do
      response.should redirect_to('/neighborhoods')
    end
  end
end
