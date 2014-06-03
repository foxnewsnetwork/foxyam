class CreateFoxYamMaterialDescriptions < ActiveRecord::Migration
  def change
    create_table :fox_yam_material_descriptions do |t|
      t.string :permalink, null: false
      t.string :name, null: false
      t.text :description
      t.integer :count, null: false, default: 0
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :fox_yam_material_descriptions, :permalink, unique: true
  end
end
