# frozen_string_literal: true

module ViewHelpers
  def have_index_view_row(id, text)
    if Rails::VERSION::STRING >= "7"
      have_css "div[itemscope]>p[itemprop='#{id}']", text: text, count: 1
    else
      header = id.capitalize.tr("_", " ")
      have_selector :table_row, header => text, count: 1
    end
  end

  def have_p_with_label(label, text)
    have_xpath "//p[strong[contains(text(), '#{label}:')]]", text: text
  end

  def have_form_field(form_action, field_name, field_value)
    have_css "form[action='#{form_action}'][method='post']" do |form|
      form.has_field? field_name, with: field_value
    end
  end

  def have_form_select(form_action, select_name, selected_option)
    have_css "form[action='#{form_action}'][method='post']" do |form|
      form.has_select? select_name, selected: selected_option
    end
  end
end

RSpec.configure do |config|
  config.include ViewHelpers, type: :view
end
