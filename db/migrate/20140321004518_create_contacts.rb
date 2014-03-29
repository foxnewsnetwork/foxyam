class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :company, index: true
      t.string :name
      t.string :email
      t.string :phone
      t.timestamps
    end
  end
end
