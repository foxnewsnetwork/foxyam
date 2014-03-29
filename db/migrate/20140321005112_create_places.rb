class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :permalink
      t.timestamps
    end
    add_index :places, [:permalink]
  end
end
