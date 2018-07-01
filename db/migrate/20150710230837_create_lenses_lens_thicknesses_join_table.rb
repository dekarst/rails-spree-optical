class CreateLensesLensThicknessesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :lenses, :lens_thicknesses do |t|
      t.integer :lens_id
      t.integer :lens_thickness_id

      t.index [:lens_id, :lens_thickness_id]
      t.index [:lens_thickness_id, :lens_id]
    end
  end
end
