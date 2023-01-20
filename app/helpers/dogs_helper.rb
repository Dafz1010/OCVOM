module DogsHelper
    def dog_pic(pic)
        image_tag "data:#{pic.content_type};base64,#{to_base64(pic.read)}"
    end
end
