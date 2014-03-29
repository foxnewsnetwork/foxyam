class AddAttachmentPictureToConversationsPictures < ActiveRecord::Migration
  def self.up
    change_table :conversations_pictures do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :conversations_pictures, :picture
  end
end
