class CreateGtpsDocuments < ActiveRecord::Migration
  def change
    create_table :gtps_documents do |t|
      t.references :contract, index: true
      t.string :document_type, null: false
      t.datetime :approved_at
      t.datetime :rejected_at
      t.timestamps
    end
  end
end
