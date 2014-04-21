class CreateFoxYamAttachedFilesAttachedFilesEmails < ActiveRecord::Migration
  def change
    create_table :attached_files_emails do |t|
      t.references :attached_file, index: true
      t.references :email, index: true
      t.timestamps
    end
  end
end
