class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :permalink, null: false
      t.timestamps
    end
    add_index :companies, [:permalink], unique: true
  end
end
