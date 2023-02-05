module Authentication
    extend ActiveSupport::Concern
  
    included do
      before_action :authenticate_user!
      before_action :approved_user!
    end
  
    def authenticate_user!
        unless current_user
            session[:intended_url] = request.url
            redirect_to root_path, alert: "Please sign in first"
        end
    end

    def approved_user!
        unless current_user.role
            redirect_to admin_approval_path, alert: "Restricted Access"
        end
    end
end