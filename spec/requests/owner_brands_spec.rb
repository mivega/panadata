require 'spec_helper'

describe "OwnerBrands" do
  describe "GET /owner_brands" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get owner_brands_path
      response.status.should be(200)
    end
  end
end
