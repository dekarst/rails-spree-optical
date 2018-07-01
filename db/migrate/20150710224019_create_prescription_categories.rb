class CreatePrescriptionCategories < ActiveRecord::Migration
  def change
    create_table :prescription_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
