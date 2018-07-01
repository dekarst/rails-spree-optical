class CreateLensesLensProtectionsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :lenses, :lens_protections do |t|
      t.integer :lens_id
      t.integer :lens_protection_id

      t.index [:lens_id, :lens_protection_id]
      t.index [:lens_protection_id, :lens_id]
    end
  end
end
