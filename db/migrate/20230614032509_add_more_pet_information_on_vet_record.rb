class AddMorePetInformationOnVetRecord < ActiveRecord::Migration[7.0]
  def change
    # add plave_id to vet_record
    add_reference :vet_records, :place, null: false, foreign_key: true, default: 1
    add_column :vet_records, :pet_owner, :string
    add_column :vet_records, :pet_owner_phone, :string
    add_column :vet_records, :breed, :string
    add_column :vet_records, :pet_gender, :boolean
    add_column :vet_records, :pet_neutered, :boolean   
  end
end
