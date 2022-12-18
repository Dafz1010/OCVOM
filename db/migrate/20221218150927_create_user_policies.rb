class CreateUserPolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :user_policies do |t|

      t.timestamps
    end
  end
end
