class CreateFaceShapes < ActiveRecord::Migration
  def change
    create_table :face_shapes do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
