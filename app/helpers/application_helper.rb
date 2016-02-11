module ApplicationHelper
  def time_12_format(time)
    time && time.to_s(:time12)
  end
end
