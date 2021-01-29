module ApplicationHelper
  def time_12_format(time)
    time && time.to_s(:time12)
  end

  def ratio_percent(value)
    return unless value.is_a? Float
    number_to_percentage 100 * value, precision: 2
  end

  def ratio_class(value)
    return unless value.is_a? Float
    case
      when value >= 0.75
        ' class=''ratio_red'''
      when value >= 0.5
        ' class=''ratio_green'''
      when value >= 0.25
        ' class=''ratio_blue'''
    end
  end

  def count_week_helper(count)
    return if count == 0

    "&nbsp;(#{count})".html_safe
  end
end
