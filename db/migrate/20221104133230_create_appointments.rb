class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :dog, null: false, foreign_key: true
      t.date :booked_appointment_date

      t.timestamps
    end
  end
end
