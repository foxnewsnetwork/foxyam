# == Schema Information
#
# Table name: conversations_pictures
#
#  id                   :integer          not null, primary key
#  conversation_id      :integer
#  notes                :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class FoxYam::Conversations::Picture < FoxYam::Conversations::RawLog
  self.table_name = 'conversations_pictures'
  belongs_to :conversation, 
    class_name: 'FoxYam::Conversation'

  has_many :attached_file_relationships,
    class_name: 'FoxYam::AttachedFiles::AttachedFilesConversationsPictures',
    foreign_key: :picture_id

  has_many :attached_files,
    class_name: 'FoxYam::AttachedFile',
    through: :attached_file_relationships
  alias_method :pictures, :attached_files


end
