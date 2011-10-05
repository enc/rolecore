require 'spec_helper'

describe "relation_properties/edit.html.haml" do
  before(:each) do
    @relation_property = assign(:relation_property, stub_model(RelationProperty,
      :relation_id => 1
    ))
  end

  it "renders the edit relation_property form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => relation_properties_path(@relation_property), :method => "post" do
      assert_select "input#relation_property_relation_id", :name => "relation_property[relation_id]"
    end
  end
end
