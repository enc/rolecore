require 'spec_helper'

describe "translations/show.html.haml" do
  before(:each) do
    @translation = assign(:translation, stub_model(Translation,
      :text => "Text",
      :lang => "Lang"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Text/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Lang/)
  end
end
