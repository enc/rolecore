require 'spec_helper'

describe "roles/show.html.haml" do
  before(:each) do
    @role = assign(:role, stub_model(Role,
      :name => "Name",
      :weight => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
