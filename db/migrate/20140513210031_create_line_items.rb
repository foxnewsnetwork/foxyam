class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :offer, index: true
      t.string :item_description
      t.integer :weight
      t.decimal :unit_price, precision: 12, scale: 5
      t.timestamps
    end
  end
end
