class AddUuidToDogModel < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :uuid, :uuid, default: 'uuid_generate_v4()'
  end
end
