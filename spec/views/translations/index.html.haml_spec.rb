require 'spec_helper'

describe "translations/index.html.haml" do
  before(:each) do
    assign(:translations, [
      stub_model(Translation,
        :text => "Text",
        :lang => "Lang"
      ),
      stub_model(Translation,
        :text => "Text",
        :lang => "Lang"
      )
    ])
  end

  it "renders a list of translations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Text".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Lang".to_s, :count => 2
  end
end
