class AddArchivedInDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :archived, :boolean
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
