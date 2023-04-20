module ApplicationHelper
	def controller_stylesheet_link_tag
		stylesheet_link_tag params[:controller]
	end

	def has_profile_image(element)
		case element
		when "div"
			"style=background-image:url(data:#{current_user.profile_image.content_type};base64,#{to_base64(current_user.profile_image.read)})" if current_user.profile_image.present?
		when "img"
			"src=data:#{current_user.profile_image.content_type};base64,#{to_base64(current_user.profile_image.read)}" if current_user.profile_image.present?
		end
	end

	def to_base64(data)
		Base64.strict_encode64(data)
	end

	def convert_to_years_months(months)
		years = months / 12
		remaining_months = months % 12
		if years > 0
		  if remaining_months > 0
			"#{years} year, #{remaining_months} month old"
		  else
			"#{years} year old"
		  end
		else
		  "#{remaining_months} month old"
		end
	end

    def status_condition_tags(name)
        case name
        when "Healthy"
            content_tag :div, "Healthy", class: "m-1 bg-success text-white border border-dark rounded-pill px-2", style: "width:fit-content"
        when "Adopted"
            content_tag :div, "Adopted", class: "m-1 bg-info border border-dark rounded-pill px-2", style: "width:fit-content"
        when "Unhealthy or Injured"
            content_tag :div, "Unhealthy or Injured", class: "m-1 bg-danger text-white border border-dark rounded-pill px-2", style: "width:fit-content"
        when "Recovery"
            content_tag :div, "Recovery", class: "m-1 bg-warning border border-dark rounded-pill px-2", style: "width:fit-content"
        when "Lost"
            content_tag :div, "Lost", class: "m-1 bg-light border border-dark rounded-pill px-2", style: "width:fit-content"
        end
    end
end
