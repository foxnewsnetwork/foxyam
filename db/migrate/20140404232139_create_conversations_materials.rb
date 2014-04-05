class CreateConversationsMaterials < ActiveRecord::Migration
  def change
    create_table :conversations_materials do |t|
      t.references :conversation, index: true
      t.string :material
      t.string :notes
      t.timestamps
    end
  end
end
