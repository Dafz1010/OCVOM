class AdminApprovalController < ApplicationController
  def index
    redirect_to dashboard_path if current_user.role
  end
end
