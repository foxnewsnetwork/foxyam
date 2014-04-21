class AddAttachmentTheFileToFoxYamAttachedFiles < ActiveRecord::Migration
  def self.up
    change_table :fox_yam_attached_files do |t|
      t.attachment :the_file
    end
  end

  def self.down
    drop_attached_file :fox_yam_attached_files, :the_file
  end
end
