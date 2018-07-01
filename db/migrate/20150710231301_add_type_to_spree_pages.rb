class AddTypeToSpreePages < ActiveRecord::Migration
  def change
    add_column :spree_pages, :type, :string
  end
end
