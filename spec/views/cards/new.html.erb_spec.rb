require 'spec_helper'

describe "cards/new" do
  before(:each) do
    assign(:card, stub_model(Card,
      :question => "MyString",
      :answer => "MyString"
    ).as_new_record)
  end

  it "renders new card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cards_path, "post" do
      assert_select "input#card_question[name=?]", "card[question]"
      assert_select "input#card_answer[name=?]", "card[answer]"
    end
  end
end
