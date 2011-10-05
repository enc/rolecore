require 'spec_helper'

describe "relation_properties/show.html.haml" do
  before(:each) do
    @relation_property = assign(:relation_property, stub_model(RelationProperty,
      :relation_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
