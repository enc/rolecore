require 'spec_helper'

describe "badges/show.html.haml" do
  before(:each) do
    @badge = assign(:badge, stub_model(Badge,
      :score => 1,
      :message_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
