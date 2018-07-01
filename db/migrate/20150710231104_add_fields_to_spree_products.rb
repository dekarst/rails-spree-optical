class AddFieldsToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :type, :string
    add_column :spree_products, :prescription_category_id, :integer
    add_column :spree_products, :lens_type_id, :integer
    add_column :spree_products, :lens_thickness_id, :integer
    add_column :spree_products, :lens_protection_id, :integer
    add_column :spree_products, :display_name, :string
    add_column :spree_products, :lens_required, :boolean
    add_column :spree_products, :position, :integer
  end
end
