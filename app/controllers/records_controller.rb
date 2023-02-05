class RecordsController < ApplicationController
    include Authentication
    def show
        @records = Dog.all
        if params[:name].present?
            @records = @records.joins(:breed,:place,:dog_states,:conditions).where("public_id ILIKE ? OR breeds.name ILIKE ? OR places.name ILIKE ? OR dog_states.name ILIKE ? OR conditions.name ILIKE ? ", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%").order("updated_at DESC").distinct
        else
            @records = @records.where(archived_at: nil).order("updated_at DESC")
        end
    end

    private

    def record_params
        params.require(:dog).permit(:name)
    end
end
