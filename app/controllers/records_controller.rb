class RecordsController < ApplicationController
    include Authentication
    def show
        @records = Dog.all
        date_pattern = /[A-Z][a-z]{2} \d{2}, \d{4} - [A-Z][a-z]{2} \d{2}, \d{4}/
        if params[:range].present?
            # binding.pry_remote
            if params[:range].length == 27 && params[:range].match?(date_pattern)
                start_date = Date.parse(params[:range].split(" - ")[0])
                end_date = Date.parse(params[:range].split(" - ")[1])
                @records = @records.where(created_at: start_date..end_date)
            else
                redirect_to records_path, flash: { alert: "Invalid Request" }
            end
        end
        if params[:name].present?
            @records = @records.joins(:breed,:place,:dog_states,:conditions).where("public_id ILIKE ? OR breeds.name ILIKE ? OR places.name ILIKE ? OR dog_states.name ILIKE ? OR conditions.name ILIKE ? ", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%").order("updated_at DESC").distinct
        else
            @records = @records.order("updated_at DESC")
        end
    end
end
