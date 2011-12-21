require 'spec_helper'

describe "users/new.html.haml" do
  before(:each) do
    assign(:user, stub_model(User,
      :foreign_id => "MyString",
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_foreign_id", :name => "user[foreign_id]"
      assert_select "input#user_name", :name => "user[name]"
    end
  end
end
