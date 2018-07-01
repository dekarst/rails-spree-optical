class CreateFrameColors < ActiveRecord::Migration
  def change
    create_table :frame_colors do |t|
      t.integer :frame_id
      t.string :name
      t.string :color_code
      t.string :color_image
      t.boolean :use_image
      t.integer :position

      t.timestamps
    end
  end
end
