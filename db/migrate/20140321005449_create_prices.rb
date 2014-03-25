class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :terms
      t.references :place, index: true
      t.decimal :dollars_per_pound

      t.timestamps
    end
  end
end
