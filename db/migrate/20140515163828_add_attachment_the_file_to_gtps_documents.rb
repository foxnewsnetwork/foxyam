class AddAttachmentTheFileToGtpsDocuments < ActiveRecord::Migration
  def self.up
    change_table :gtps_documents do |t|
      t.attachment :the_file
    end
  end

  def self.down
    drop_attached_file :gtps_documents, :the_file
  end
end
