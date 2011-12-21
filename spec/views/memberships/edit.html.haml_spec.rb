require 'spec_helper'

describe "memberships/edit.html.haml" do
  before(:each) do
    @membership = assign(:membership, stub_model(Membership,
      :user_id => 1,
      :role_id => 1
    ))
  end

  it "renders the edit membership form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => memberships_path(@membership), :method => "post" do
      assert_select "input#membership_user_id", :name => "membership[user_id]"
      assert_select "input#membership_role_id", :name => "membership[role_id]"
    end
  end
end
