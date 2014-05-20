class CreateGtpsItems < ActiveRecord::Migration
  def change
    create_table :gtps_items do |t|
      t.references :contract, index: true
      t.string :item_description
      t.decimal :quantity, precision: 12, scale: 5
      t.string :quantity_unit
      t.decimal :unit_price, precision: 12, scale: 5
      t.timestamps
    end
  end
end
