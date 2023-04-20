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

  def exp_status(file_type)
    case file_type
    when "PDF"
      status.map { |x| [{ content: x, borders: [] }] }
    when "CSV"
      "\"#{status.join(", ")}\""
    when "Excel"
      status.join(", ")
    end
  end

  def exp_conditions(file_type)
    case file_type
    when "PDF"
      condition_names.map { |x| [{ content: x, borders: [] }] }
    when "CSV"
      "\"#{condition_names.join(", ")}\""
    when "Excel"
      condition_names.join(", ")
    end
  end

  def self.export(date_range, group, file_type)
    list = []
    case group
    when "all"
      list = self.where(created_at: date_range, archived_at: nil)
    when "healthy"
      list = self.where(created_at: date_range, archived_at: nil).joins(:conditions).where(conditions: { name: "Healthy" })
    when "operation"
      list = self.where(created_at: date_range, archived_at: nil).joins(:conditions).where(conditions: { name: "Operation" })
    when "disposed"
      list = self.where(created_at: date_range, archived_at: nil).joins(:conditions).where(conditions: { name: "Disposed" })
    end
    data = [ 
      ["Public ID", "Breed","Sex","Age","Neutered","Owner","Location", "Status", "Condition", "Date"] 
    ]
    list.each do |d|  
      data += [[d.public_id,d.breed_name,d.exp_sex,d.exp_age(d.age),d.exp_neutered,"N/A",d.location,d.exp_status(file_type),d.exp_conditions(file_type),d.exp_date]]
    end
    data
  end
end
