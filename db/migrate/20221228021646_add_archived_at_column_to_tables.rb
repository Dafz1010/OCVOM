class AddArchivedAtColumnToTables < ActiveRecord::Migration[7.0]
  def change
    # Exclude the Versions table
    tables_to_modify = ActiveRecord::Base.connection.tables - ['versions', 'schema_migrations', 'ar_internal_metadata']

    tables_to_modify.each do |table_name|
      add_column table_name, :archived_at, :datetime, null: true
    end
  end
end
