class AddFieldsToSpreeLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :type, :string
    add_column :spree_line_items, :lens_thickness_option_id, :integer
    add_column :spree_line_items, :lens_id, :integer
    add_column :spree_line_items, :frame_line_item_id, :integer
  end
end
