module Authentication
    extend ActiveSupport::Concern
  
    included do
      before_action :authenticate_user!
      before_action :changed_password_user!
    end
  
    def authenticate_user!
        unless current_user
            session[:intended_url] = request.url
            redirect_to root_path, alert: "Please sign in first"
        end
    end

    def changed_password_user!
        unless current_user.first_loggedin?
            redirect_to first_login_index_path, alert: "Change your password first"
        end
    end

end