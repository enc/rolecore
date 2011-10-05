require 'spec_helper'

describe "relations/edit.html.haml" do
  before(:each) do
    @relation = assign(:relation, stub_model(Relation,
      :parent_id => 1,
      :child_id => 1,
      :child_type => "MyString"
    ))
  end

  it "renders the edit relation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => relations_path(@relation), :method => "post" do
      assert_select "input#relation_parent_id", :name => "relation[parent_id]"
      assert_select "input#relation_child_id", :name => "relation[child_id]"
      assert_select "input#relation_child_type", :name => "relation[child_type]"
    end
  end
end
