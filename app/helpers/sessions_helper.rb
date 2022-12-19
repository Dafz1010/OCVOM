module SessionsHelper
    
    def log_in(user)
        session[:user_id] = user.id
    end

    def log_out
        session[:intended_url] = nil
        session.delete(:user_id)
    end
end
