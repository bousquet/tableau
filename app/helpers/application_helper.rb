# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def display_flash
    key = if flash[:error]
      :error
    elsif flash[:notice]
      :notice
    end
    content_tag(:div, :class => "flash", :id => "flash#{key.to_s.capitalize}") do
      content_tag(:h2, flash[key])
    end
  end
end
