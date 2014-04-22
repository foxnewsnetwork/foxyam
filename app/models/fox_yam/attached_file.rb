# == Schema Information
#
# Table name: fox_yam_attached_files
#
#  id                    :integer          not null, primary key
#  description           :string(255)
#  deleted_at            :datetime
#  created_at            :datetime
#  updated_at            :datetime
#  the_file_file_name    :string(255)
#  the_file_content_type :string(255)
#  the_file_file_size    :integer
#  the_file_updated_at   :datetime
#

class FoxYam::AttachedFile < ActiveRecord::Base
  self.table_name = 'fox_yam_attached_files'
  has_many :email_relationships,
    foreign_key: 'attached_file_id',
    class_name: 'FoxYam::AttachedFiles::AttachedFilesEmails'
  has_many :emails,
    through: :email_relationships,
    class_name: 'FoxYam::Email'

  has_many :picture_relationships,
    foreign_key: 'attached_file_id',
    class_name: 'FoxYam::AttachedFiles::AttachedFilesConversationsPictures'
  has_many :pictures,
    through: :picture_relationships,
    class_name: 'FoxYam::Conversations::Picture'
  has_attached_file :the_file,
    url: '/storage/files/:id/:basename.:extension',
    path: ':rails_root/public/storage/files/:id/:basename.:extension'


  def claimed_by_picture?
    pictures.present?
  end
end
