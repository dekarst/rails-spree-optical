class CreatePrescriptionLimitations < ActiveRecord::Migration
  def change
    create_table :prescription_limitations do |t|
      t.integer :limitationable_id
      t.string :limitationable_type
      t.integer :prescription_item_id
      t.string :min
      t.string :max

      t.timestamps
    end
  end
end
