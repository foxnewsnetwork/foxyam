class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :company, index: true

      t.timestamps
    end
  end
end
