class CreateEnvelopesOrigins < ActiveRecord::Migration
  def change
    create_table :envelopes_origins do |t|
      t.references :envelope, index: true
      t.string :origin_type, null: false, default: 'from'
      t.string :email_address, null: false
      t.string :email_presentation
      t.timestamps
    end
  end
end
