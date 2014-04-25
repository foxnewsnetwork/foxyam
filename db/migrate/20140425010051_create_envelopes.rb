class CreateEnvelopes < ActiveRecord::Migration
  def change
    create_table :envelopes do |t|
      t.references :email, index: true
      t.string :subject
      t.timestamps
    end
  end
end
