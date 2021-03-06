class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :permalink
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :merchants, [:permalink], unique: true
  end
end
