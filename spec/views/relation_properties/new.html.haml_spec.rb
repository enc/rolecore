require 'spec_helper'

describe "relation_properties/new.html.haml" do
  before(:each) do
    assign(:relation_property, stub_model(RelationProperty,
      :relation_id => 1
    ).as_new_record)
  end

  it "renders new relation_property form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => relation_properties_path, :method => "post" do
      assert_select "input#relation_property_relation_id", :name => "relation_property[relation_id]"
    end
  end
end
