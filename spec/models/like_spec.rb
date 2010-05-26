require 'spec_helper'

describe Like do
  it "should require a twitter user" do
    Like.create.errors.on(:created_by).should_not be_nil
  end
end
