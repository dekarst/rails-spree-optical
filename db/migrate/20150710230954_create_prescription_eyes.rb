class CreatePrescriptionEyes < ActiveRecord::Migration
  def change
    create_table :prescription_eyes do |t|
      t.string :name
      t.integer :prescription_id
      t.integer :prescription_category_id
      t.boolean :checked
      t.integer :quantity

      t.timestamps
    end
  end
end
