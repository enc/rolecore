require 'spec_helper'

describe "badges/index.html.haml" do
  before(:each) do
    assign(:badges, [
      stub_model(Badge,
        :score => 1,
        :message_id => 1
      ),
      stub_model(Badge,
        :score => 1,
        :message_id => 1
      )
    ])
  end

  it "renders a list of badges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
