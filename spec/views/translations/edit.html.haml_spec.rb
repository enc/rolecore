require 'spec_helper'

describe "translations/edit.html.haml" do
  before(:each) do
    @translation = assign(:translation, stub_model(Translation,
      :text => "MyString",
      :lang => "MyString"
    ))
  end

  it "renders the edit translation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => translations_path(@translation), :method => "post" do
      assert_select "input#translation_text", :name => "translation[text]"
      assert_select "input#translation_lang", :name => "translation[lang]"
    end
  end
end
