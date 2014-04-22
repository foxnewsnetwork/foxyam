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

  validates_with Conversations::Pictures::Validator

  def initialize(conversation)
    @conversation = conversation
  end

  def attachments
    email.attachments
  end

  def email_text
    Kramdown::Document.new(email.plain_object.raw_source).to_html.html_safe
  end

  def picture_tag!
    Conversations::Pictures::Result.new _tag && _relationship
  end

  def attached_file
    @attached_file ||= attachments.find_by_id attached_file_id
  end
  private
  def _tag
    @tag ||= conversation.pictures.create! notes: description
  end
  def _relationship
    @relationship ||= _tag.attached_file_relationships.create! attached_file: attached_file
  end
end