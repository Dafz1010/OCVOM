json.extract! dog, :id, :breed_id, :location, :has_color, :dog_state_id, :image_file_name, :age, :gender, :in_pound, :created_at, :updated_at
json.url dog_url(dog, format: :json)
