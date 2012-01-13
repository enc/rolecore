require 'spec_helper'

describe "badges/new.html.haml" do
  before(:each) do
    assign(:badge, stub_model(Badge,
      :score => 1,
      :message_id => 1
    ).as_new_record)
  end

  it "renders new badge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => badges_path, :method => "post" do
      assert_select "input#badge_score", :name => "badge[score]"
      assert_select "input#badge_message_id", :name => "badge[message_id]"
    end
  end
end
