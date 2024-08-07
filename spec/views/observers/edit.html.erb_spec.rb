# frozen_string_literal: true

require "rails_helper"

RSpec.describe "observers/edit", type: :view do
  let(:observer) do
    Observer.create!(
      first_name: "MyString",
      last_name: "MyString",
      email: "MyString"
    )
  end

  before(:each) do
    assign(:observer, observer)
  end

  it "renders the edit observer form" do
    render

    assert_select "form[action=?][method=?]", observer_path(observer), "post" do
      assert_select "input[name=?]", "observer[first_name]"

      assert_select "input[name=?]", "observer[last_name]"

      assert_select "input[name=?]", "observer[email]"
    end
  end
end
