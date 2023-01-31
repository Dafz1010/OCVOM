module ApplicationHelper
	def controller_stylesheet_link_tag
		stylesheet_link_tag params[:controller]
	end

	def has_profile_image
		"style=background-image:url(data:#{current_user.profile_image.content_type};base64,#{to_base64(current_user.profile_image.read)})" if current_user.profile_image.present?
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
end
