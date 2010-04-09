require 'spec_helper'

describe AleHouse do
  it{should validate_presence_of(:name)}
  it{should validate_presence_of(:address)}
  it{should belong_to(:neighborhood)}
end