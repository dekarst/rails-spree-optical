class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :url
      t.string :image
      t.integer :position, default: 1
      t.timestamps
    end
  end
end
