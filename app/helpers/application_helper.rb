module ApplicationHelper
  def time_12_format(time)
    time && time.to_s(:time12)
  end

  def change_percent(value)
    return unless value.is_a? Float
    number_to_percentage value, precision: 2
  end

  def ratio_percent(value)
    return unless value.is_a? Float
    number_to_percentage 100 * value, precision: 2
  end

  def ratio_style(value)
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

  def change_class(value)
    return unless value.is_a? Float
    ' red' if value < 0
  end

  def count_class(count, high, low)
    return unless count
    if count == 'Count Week'
      'count_week'
    elsif count == high
      'bold'
    elsif count == low && count != high
      'bold red'
    end
  end

  def high_class(count, high)
    if count && count == high
      'bold'
    end
  end

  def low_class(count, high, low)
    if count && count == low && count != high
      'bold red'
    end
  end

  def record_class(is_record)
    is_record ? 'red' : ''
  end

  def selected_year_class(current, selected)
    'selected_year' if current == selected
  end

  def count_week_helper(count)
    return if count == 0

    "&nbsp;(#{count})".html_safe
  end
end
