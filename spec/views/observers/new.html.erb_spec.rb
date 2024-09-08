# frozen_string_literal: true

require "rails_helper"

RSpec.describe "observers/new", type: :view do
  before do
    assign(:observer, Observer.new(
      first_name: "MyString",
      last_name: "MyString",
      email: "MyString",
    ))
  end

  it "renders new observer form" do
    render

    assert_select "form[action=?][method=?]", observers_path, "post" do
      assert_select "input[name=?]", "observer[first_name]"

      assert_select "input[name=?]", "observer[last_name]"

      assert_select "input[name=?]", "observer[email]"
    end
  end
end
