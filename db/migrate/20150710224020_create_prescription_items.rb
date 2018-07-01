class CreatePrescriptionItems < ActiveRecord::Migration
  def change
    create_table :prescription_items do |t|
      t.integer :prescription_category_id
      t.string :name
      t.string :display_name
      t.integer :position

      t.timestamps
    end
  end
end
