class CreateVaccines < ActiveRecord::Migration[7.0]
  def change
    create_table :vaccines do |t|
      t.string :name
      t.datetime :archived_at

      t.timestamps
    end
  end
end
