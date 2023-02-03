module DogsHelper
    def dog_pic(pic,class_string="", style_string="")
        image_tag "data:#{pic.content_type};base64,#{to_base64(pic.read)}", class: class_string, style: style_string
    end

    def status_condition_tags(name)
        case name
        when "Healthy"
            content_tag :div, "Healthy", class: "mx-1 bg-success text-white border border-dark rounded-pill px-2", style: "width:fit-content"
        when "Adopted"
            content_tag :div, "Adopted", class: "mx-1 bg-info border border-dark rounded-pill px-2", style: "width:fit-content"
        when "Unhealthy or Injured"
            content_tag :div, "Unhealthy or Injured", class: "mx-1 bg-danger text-white border border-dark rounded-pill px-2", style: "width:fit-content"
        when "Recovery"
            content_tag :div, "Recovery", class: "mx-1 bg-warning border border-dark rounded-pill px-2", style: "width:fit-content"
        when "Lost"
            content_tag :div, "Lost", class: "mx-1 bg-light border border-dark rounded-pill px-2", style: "width:fit-content"
        end
    end
end
