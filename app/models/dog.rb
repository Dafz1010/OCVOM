class Dog < ApplicationRecord
  
  has_paper_trail
  belongs_to :breed
  belongs_to :place
  belongs_to :user  
  has_and_belongs_to_many :dog_states
  has_and_belongs_to_many :vaccines
  has_and_belongs_to_many :conditions
  has_many :dog_pictures, dependent: :destroy
  accepts_nested_attributes_for :dog_pictures, :allow_destroy => true

  def breed_name
    breed.name
  end

  def status
    dog_states.pluck(:name)
  end

  def location
    place.name
  end

  def sex
    gender ? "Male" : "Female"
  end
  
  def size_name
    size ? "Puppy" : "Adult"
  end

  def condition_names
    conditions.pluck(:name)
  end

  def disposed?
    condition_names.include?("Disposed")
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
    created_at.localtime.strftime("%b %d, %Y %I:%M %p")
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

  def exp_status
    status.map { |x| [{ content: x, borders: [] }] }
  end

  def exp_conditions
    condition_names.map { |x| [{ content: x, borders: [] }] }
  end

  def self.export(date_range = "")
    list = self.all.where(archived_at: nil)
    pdf = Prawn::Document.new(page_layout: :landscape, page_size: "LEGAL")
    data = [ 
      ["Public ID", "Breed","Sex","Age","Neutered","Owner","Location", "Status", "Condition", "Date"] 
    ]
    list.each do |d|
      data += [[d.public_id,d.breed_name,d.exp_sex,d.exp_age(d.age),d.exp_neutered,"N/A",d.location,d.exp_status,d.exp_conditions,d.exp_date]]
    end
    pdf.table data, :position => :center, :header => true
    pdf
  end
end
