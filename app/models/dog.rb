class Dog < ApplicationRecord
  
  has_paper_trail
  belongs_to :breed
  belongs_to :dog_state
  belongs_to :place
  belongs_to :condition

  has_many :dog_pictures, dependent: :destroy
  accepts_nested_attributes_for :dog_pictures, :allow_destroy => true

  def breed_name
    breed.name
  end

  def status
    dog_state.name
  end

  def location
    place.name
  end

  def sex
    gender ? "Male" : "Female"
  end

  def condition_name
    condition.name
  end

  def archive
    self.update(archived_at: Time.now)
  end

  def archived?
    archived_at?
  end

  def exp_neutered
    neutered ? "Yes" : "No"
  end

  def exp_sex
    gender ? "M" : "F"
  end

  def exp_date
    created_at.strftime("%b %d, %Y %I:%M %p")
  end

  def exp_age(age)
		years = age / 12
		remaining_months = age % 12
		if years > 0
		  if remaining_months > 0
			"#{years}yr #{remaining_months}mon"
		  else
			"#{years}yr"
		  end
		else
		  "#{remaining_months}mon"
		end

  end

  def self.export(date_range = "")
    list = self.all.where(archived_at: nil)
    pdf = Prawn::Document.new(page_layout: :landscape, page_size: "LEGAL")
    data = [ 
      ["Public ID", "Breed","Sex","Age","Neutered","Owner","Location", "Status", "Condition", "Date"] 
    ]
    list.each do |d|
      data += [[d.public_id,d.breed_name,d.exp_sex,d.exp_age(d.age),d.exp_neutered,"N/A",d.location,d.status,d.condition_name,d.exp_date]]
    end
    pdf.table data, :position => :center
    pdf
  end
end
