class RemovePlaceDefaultFromVetRecord < ActiveRecord::Migration[7.0]
  def change
    change_column_default :vet_records, :place_id, nil
  end
end
