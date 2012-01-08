require 'spec_helper'

describe "translations/new.html.haml" do
  before(:each) do
    assign(:translation, stub_model(Translation,
      :text => "MyString",
      :lang => "MyString"
    ).as_new_record)
  end

  it "renders new translation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => translations_path, :method => "post" do
      assert_select "input#translation_text", :name => "translation[text]"
      assert_select "input#translation_lang", :name => "translation[lang]"
    end
  end
end
