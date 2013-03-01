require 'spec_helper'

describe "cards/show" do
  before(:each) do
    @card = assign(:card, stub_model(Card,
      :question => "Question",
      :answer => "Answer"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Question/)
    rendered.should match(/Answer/)
  end
end
