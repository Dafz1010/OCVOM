module DogsHelper
    def dog_pic(pic,class_string="", style_string="")
        image_tag "data:#{pic.content_type};base64,#{to_base64(pic.read)}", class: class_string, style: style_string
    end
end
