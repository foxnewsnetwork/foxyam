class Conversations::Pictures::Interactor < InteractorBase
  Fields = [
    :description,
    :attached_file_id
  ]
  attr_accessor :attributes, :conversation
  attr_reader :attached_file
  attr_hash_accessor *Fields

  delegate :negotiation,
    :email,
    to: :conversation

  delegate :from_address,
    to: :email

  delegate :email_address,
    :email_presentation,
    to: :from_address

  validates_with Conversations::Pictures::Validator

  def initialize(conversation)
    @conversation = conversation
  end

  def attachments
    email.attachments
  end

  def email_text
    Kramdown::Document.new(email.plain_content).to_html.html_safe
  end

  def picture_tag!
    Conversations::Pictures::Result.new _tag && _relationship
  end

  # Well, future security problem here, but we'll deal with it when it becomes a problem
  def attached_file
    @attached_file ||= FoxYam::AttachedFile.find_by_id attached_file_id
  end
  private
  def _tag
    @tag ||= conversation.pictures.create! notes: description
  end
  def _relationship
    @relationship ||= _tag.attached_file_relationships.create! attached_file: attached_file
  end
end