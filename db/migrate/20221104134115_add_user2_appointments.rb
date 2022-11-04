class AddUser2Appointments < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointments, :user, index: true
  end
end
