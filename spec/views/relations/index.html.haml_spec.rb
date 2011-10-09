require 'spec_helper'

describe "relations/index.html.haml" do
  before(:each) do
    assign(:relations, [
      stub_model(Relation,
        :parent_id => 1,
        :child_id => 1,
        :child_type => "Child Type"
      ),
      stub_model(Relation,
        :parent_id => 2,
        :child_id => 2,
        :child_type => "Child Type"
      )
    ])
  end

  it "renders a list of relations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 2.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Child Type".to_s, :count => 2
  end
end
