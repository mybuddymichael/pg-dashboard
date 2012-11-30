module ApplicationHelper

  def title
    base_title = "Dashboard"
    if @title.nil?
      base_title
    else
      "#{@title} #{base_title}"
    end
  end
end
