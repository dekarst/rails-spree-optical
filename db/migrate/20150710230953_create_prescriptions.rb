class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.integer :prescriptionable_id
      t.string :prescriptionable_type
      t.integer :order_id
      t.integer :chosen_method
      t.string :scanned_document
      t.text :observation

      t.timestamps
    end
  end
end
