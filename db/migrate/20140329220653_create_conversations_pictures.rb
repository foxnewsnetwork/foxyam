class CreateConversationsPictures < ActiveRecord::Migration
  def change
    create_table :conversations_pictures do |t|
      t.references :conversation, index: true
      t.string :notes
    end
  end
end
