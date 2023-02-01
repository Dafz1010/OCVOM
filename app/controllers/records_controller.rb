class RecordsController < ApplicationController
    include Authentication
    def show
        status = DogState.pluck(:name)
        if params[:name].present?
            if status.include?(params[:name])
                @records = DogState.find_by(name: params[:name]).dogs.where(archived_at: nil).order("updated_at DESC")
            else
                redirect_to users_path, flash: {alert: "Invalid Page" }
            end
        else
            @records = Dog.where(archived_at: nil).order("updated_at DESC")
        end
    end

    private

    def record_params
        params.require(:dog).permit(:name)
    end
end
