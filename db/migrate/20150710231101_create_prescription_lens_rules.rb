class CreatePrescriptionLensRules < ActiveRecord::Migration
  def change
    create_table :prescription_lens_rules do |t|
      t.integer :prescription_item_id
      t.string :operation
      t.string :value
      t.string :complementary_operation
      t.string :complementary_value

      t.timestamps
    end
  end
end
