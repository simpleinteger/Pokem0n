require 'spec_helper'

describe GameController do

  describe "GET 'play'" do
    it "returns http success" do
      get 'play'
      response.should be_success
    end
  end

  describe "GET 'check_answer'" do
    it "returns http success" do
      get 'check_answer'
      response.should be_success
    end
  end

end
