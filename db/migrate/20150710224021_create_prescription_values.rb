class CreatePrescriptionValues < ActiveRecord::Migration
  def change
    create_table :prescription_values do |t|
      t.integer :prescription_item_id
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
