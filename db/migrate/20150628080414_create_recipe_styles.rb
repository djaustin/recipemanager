class CreateRecipeStyles < ActiveRecord::Migration
  def change
    create_table :recipe_styles do |t|
      t.references :recipe, index: true
      t.references :style, index: true

      t.timestamps
    end
  end
end
