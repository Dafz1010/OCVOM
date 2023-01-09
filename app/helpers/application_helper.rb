module ApplicationHelper
	def controller_stylesheet_link_tag
		stylesheet_link_tag params[:controller]
	end

	def has_profile_image
		"style=background-image:url(data:#{current_user.profile_image.content_type};base64,#{Base64.strict_encode64(current_user.profile_image.read)})" if current_user.profile_image.present?
	end
end
