require 'spec_helper'

describe "cards/edit" do
  before(:each) do
    @card = assign(:card, stub_model(Card,
      :question => "MyString",
      :answer => "MyString"
    ))
  end

  it "renders the edit card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", card_path(@card), "post" do
      assert_select "input#card_question[name=?]", "card[question]"
      assert_select "input#card_answer[name=?]", "card[answer]"
    end
  end
end
