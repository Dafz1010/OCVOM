module SessionsHelper
    
    def log_in(user)
        user.versions.create!(event: "Login User", whodunnit: "#{user.username}") if user.first_loggedin?
        session[:user_id] = user.id
    end

    def log_out(user)
        user.versions.create!(event: "Logout User", whodunnit: "#{user.username}")
        session[:intended_url] = nil
        session.delete(:user_id)
    end
end
