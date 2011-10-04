require 'spec_helper'

describe "roles/edit.html.haml" do
  before(:each) do
    @role = assign(:role, stub_model(Role,
      :name => "MyString",
      :weight => 1
    ))
  end

  it "renders the edit role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => roles_path(@role), :method => "post" do
      assert_select "input#role_name", :name => "role[name]"
      assert_select "input#role_weight", :name => "role[weight]"
    end
  end
end
