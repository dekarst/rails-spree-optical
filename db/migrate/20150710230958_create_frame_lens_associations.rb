class CreateFrameLensAssociations < ActiveRecord::Migration
  def change
    create_table :frame_lens_associations do |t|
      t.integer :frame_id
      t.integer :lens_id

      t.timestamps
    end
  end
end
