require 'spec_helper'

describe "badges/edit.html.haml" do
  before(:each) do
    @badge = assign(:badge, stub_model(Badge,
      :score => 1,
      :message_id => 1
    ))
  end

  it "renders the edit badge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => badges_path(@badge), :method => "post" do
      assert_select "input#badge_score", :name => "badge[score]"
      assert_select "input#badge_message_id", :name => "badge[message_id]"
    end
  end
end
