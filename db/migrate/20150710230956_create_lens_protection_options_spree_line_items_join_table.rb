class CreateLensProtectionOptionsSpreeLineItemsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :lens_protection_options, :spree_line_items do |t|
      t.index [:lens_protection_option_id, :spree_line_item_id], name: 'lpoptions_lineitems_on_lineitem_id_and_lpoption_id'
      t.index [:spree_line_item_id, :lens_protection_option_id], name: 'lineitems_lpoptions_on_lineitem_id_and_lpoption_id'
    end
  end
end
