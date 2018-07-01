class CreatePrescriptionOptions < ActiveRecord::Migration
  def change
    create_table :prescription_options do |t|
      t.integer :prescription_eye_id
      t.integer :prescription_value_id

      t.timestamps
    end
  end
end
