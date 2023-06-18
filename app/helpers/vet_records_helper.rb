module VetRecordsHelper
    def sex_color(gender)
        if gender == true
            "pink"
        else
            "blue"
        end
    end

    def status_tag(status)
        unless status.blank?
            content_tag :span, status.name, class: "text-center", style: "background-color: #{status.three_colors[0]}; color: #{status.three_colors[1]}; padding: 2px 4px; border-radius: 4px; border: 3px solid #{status.three_colors[2]};"
        else
            content_tag :span, "No Status", class: "text-center", style: "background-color: #fff; color: #000; padding: 2px 4px; border-radius: 4px; border: 3px solid #000;"
        end
    end

    def condition_tag(condition)
        unless condition.blank?
            content_tag :span, condition.name, class: "text-center", style: "background-color: #{condition.three_colors[0]}; color: #{condition.three_colors[1]}; padding: 2px 4px; border-radius: 4px;border: 3px solid #{status.three_colors[2]};"
        else
            content_tag :span, "No Condition", class: "text-center", style: "background-color: #fff; color: #000; padding: 2px 4px; border-radius: 4px; border: 3px solid #000;"
        end
    end

    def status_div(status)
        unless status.blank?
            content_tag :div, status.name, class: "text-center", style: "background-color: #{status.three_colors[0]}; color: #{status.three_colors[1]}; padding: 2px 4px; border-radius: 4px;border: 3px solid #{status.three_colors[2]};"
        else
            no_status
        end
    end

    def condition_div(condition)
        unless condition.blank?
            content_tag :div, condition.name, class: "text-center", style: "background-color: #{condition.three_colors[0]}; color: #{condition.three_colors[1]}; padding: 2px 4px; border-radius: 4px;border: 3px solid #{status.three_colors[2]};"
        else
            no_condition
        end
    end

    def no_status
        content_tag :div, "No Status", class: "text-center", style: "background-color: #fff; color: #000; padding: 2px 4px; border-radius: 4px; border: 3px solid #000;"
    end

    def no_condition
        content_tag :div, "No Condition", class: "text-center", style: "background-color: #fff; color: #000; padding: 2px 4px; border-radius: 4px; border: 3px solid #000;"
    end
    
    def status_dropdown_options(status_list_options)
        # demo dropdown



        # status_list_options.map do |status|
        #     content_tag(:option, status_div(status), value: status.id)
        # end.join.html_safe
    end
      
end
