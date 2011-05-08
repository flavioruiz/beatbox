# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def field_error_message(target, field)
    unless target.errors[field].blank?
      content_tag :div, :class => "section field_error" do
        h("#{field.to_s.titleize unless field == :base} #{target.errors[field]}")
      end
    end
  end
end
