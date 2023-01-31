class DogPicture < ApplicationRecord
  has_paper_trail
  belongs_to :dog
  mount_uploader :image, DogImagesUploader

  def archive
    self.update(archived_at: Time.now)
  end

  def archived?
    archived_at?
  end
  
end
