module HomeHelper
  def browser_bar
    content_tag :div, class: "browser-header" do
      content_tag(:i, "", class: "icon-arrow-left") +
      content_tag(:i, "", class: "icon-arrow-right") + 
      content_tag(:i, "", class: "icon-refresh") +
      content_tag(:i, "", class: "icon-home") +
      content_tag(:div, "", class: "red pull-right")
    end
  end
end