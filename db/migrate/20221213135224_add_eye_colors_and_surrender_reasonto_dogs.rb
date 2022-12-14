class AddEyeColorsAndSurrenderReasontoDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :surrender_reason, :text
    add_column :dogs, :two_colored_eyes, :boolean
  end
end
