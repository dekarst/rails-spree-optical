class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.integer :menu_id
      t.integer :menu_item_id
      t.integer :page_id
      t.boolean :link_to_page
      t.text :content
      t.string :url
      t.integer :position

      t.timestamps
    end
  end
end
