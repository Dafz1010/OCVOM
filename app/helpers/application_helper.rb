module ApplicationHelper
	def controller_stylesheet_link_tag
		stylesheet_link_tag params[:controller]
	end

	def has_profile_image
		"style=background-image:url(#{current_user.profile_image_url})" if current_user.profile_image.present?
	end
end
