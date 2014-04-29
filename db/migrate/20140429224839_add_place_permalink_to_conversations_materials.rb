class AddPlacePermalinkToConversationsMaterials < ActiveRecord::Migration
  def change
    add_column :conversations_materials, :place_permalink, :string
    add_index :conversations_materials, [:place_permalink]
  end
end
