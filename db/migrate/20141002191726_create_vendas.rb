class CreateVendas < ActiveRecord::Migration
  def change
    create_table :vendas do |t|
      t.string :purchaser_name
      t.text :item_description
      t.decimal :item_price, precision: 10, scale: 2
      t.decimal :purchase_count, precision: 5, scale: 3
      t.string :merchant_address
      t.string :merchant_name

      t.timestamps
    end
  end
end
