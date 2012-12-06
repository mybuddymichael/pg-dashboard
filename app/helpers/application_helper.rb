module ApplicationHelper
  def title
    base_title = "ProGauge Dashboard"
    if @title.nil?
      base_title
    else
      "ProGauge - #{@title}"
    end
  end
end
