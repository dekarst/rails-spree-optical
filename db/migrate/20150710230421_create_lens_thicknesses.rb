class CreateLensThicknesses < ActiveRecord::Migration
  def change
    create_table :lens_thicknesses do |t|
      t.string :name
      t.text :description
      t.string :image
      t.boolean :recommended

      t.timestamps
    end
  end
end
