module Authentication
    extend ActiveSupport::Concern
  
    included do
      before_action :authenticate_user!
    end
  
    def authenticate_user!
        unless current_user
            session[:intended_url] = request.url
            redirect_to root_path, alert: "Please sign in first"
        end
    end
end