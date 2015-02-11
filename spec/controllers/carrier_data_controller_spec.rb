require 'spec_helper'

describe CarrierDataController do

  describe "GET 'check_carrier_validity'" do
    it "returns http success" do
      get 'check_carrier_validity'
      response.should be_success
    end
  end

end
