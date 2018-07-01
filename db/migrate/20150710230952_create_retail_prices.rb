class CreateRetailPrices < ActiveRecord::Migration
  def change
    create_table :retail_prices do |t|
      t.integer :variant_id
      t.decimal :amount, precision: 8, scale: 2
      t.string :currency

      t.timestamps
    end
  end
end
