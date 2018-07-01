class AddFrameColorIdToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :frame_color_id, :integer
  end
end
