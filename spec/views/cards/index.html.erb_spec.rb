require 'spec_helper'

describe "cards/index" do
  before(:each) do
    assign(:cards, [
      stub_model(Card,
        :question => "Question",
        :answer => "Answer"
      ),
      stub_model(Card,
        :question => "Question",
        :answer => "Answer"
      )
    ])
  end

  it "renders a list of cards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Question".to_s, :count => 2
    assert_select "tr>td", :text => "Answer".to_s, :count => 2
  end
end
