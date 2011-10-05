require 'spec_helper'

describe "relations/show.html.haml" do
  before(:each) do
    @relation = assign(:relation, stub_model(Relation,
      :parent_id => 1,
      :child_id => 1,
      :child_type => "Child Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Child Type/)
  end
end
