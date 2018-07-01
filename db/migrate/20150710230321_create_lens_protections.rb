class CreateLensProtections < ActiveRecord::Migration
  def change
    create_table :lens_protections do |t|
      t.string :name
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
