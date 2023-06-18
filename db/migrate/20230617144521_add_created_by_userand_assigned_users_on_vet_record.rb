class AddCreatedByUserandAssignedUsersOnVetRecord < ActiveRecord::Migration[7.0]
  def change
    add_reference :vet_records, :created_by_user, null: false, foreign_key: { to_table: :users }, default: 1
    change_column_default :vet_records, :created_by_user_id, nil
    create_table :assigned_users_vet_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vet_record, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
