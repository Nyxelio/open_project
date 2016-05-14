module ApplicationHelper
  def progress(value)
    # No comment, please...
    "<div class='progress' tabindex='0'>
    <span class='progress-meter' style='width: #{value.to_s}%'>
    <p class='progress-meter-text'>#{value.to_s}%</p>
     </span>
    </div>".html_safe
  end
end
