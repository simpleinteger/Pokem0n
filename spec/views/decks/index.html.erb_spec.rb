require 'spec_helper'

describe "decks/index" do
  before(:each) do
    assign(:decks, [
      stub_model(Deck,
        :name => "Name"
      ),
      stub_model(Deck,
        :name => "Name"
      )
    ])
  end

  it "renders a list of decks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
