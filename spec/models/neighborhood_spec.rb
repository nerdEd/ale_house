require 'spec_helper'

describe Neighborhood do
  it{should have_many(:ale_houses)}
  it{should validate_presence_of(:name)}
end