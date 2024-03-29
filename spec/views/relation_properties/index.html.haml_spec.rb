require 'spec_helper'

describe "relation_properties/index.html.haml" do
  before(:each) do
    assign(:relation_properties, [
      stub_model(RelationProperty,
        :relation_id => 1
      ),
      stub_model(RelationProperty,
        :relation_id => 1
      )
    ])
  end

  it "renders a list of relation_properties" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
