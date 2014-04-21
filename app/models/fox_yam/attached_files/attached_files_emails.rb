# == Schema Information
#
# Table name: attached_files_emails
#
#  id               :integer          not null, primary key
#  attached_file_id :integer
#  email_id         :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class FoxYam::AttachedFiles::AttachedFilesEmails < ActiveRecord::Base
  self.table_name = 'attached_files_emails'
  belongs_to :attached_file,
    class_name: 'FoxYam::AttachedFile'
  belongs_to :email,
    class_name: 'FoxYam::Email'
end
