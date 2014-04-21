# == Schema Information
#
# Table name: emails
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  email_inbox_id  :integer
#  external_id     :string(255)
#  raw_envelope    :text
#  raw_body        :text
#  created_at      :datetime
#  updated_at      :datetime
#

class FoxYam::Email < ActiveRecord::Base
  attr_accessor :address, :email

  has_many :attached_file_relationships,
    class_name: 'FoxYam::AttachedFiles::AttachedFilesEmails',
    foreign_key: 'email_id'

  has_many :attached_files,
    through: :attached_file_relationships,
    class_name: 'FoxYam::AttachedFile'
  alias_method :attachments, :attached_files
  
  belongs_to :inbox,
    foreign_key: 'email_inbox_id',
    class_name: 'FoxYam::EmailInbox'

  has_one :account,
    class_name: 'FoxYam::EmailAccount',
    through: :inbox

  has_one :merchant,
    through: :account,
    class_name: 'FoxYam::Merchant'

  belongs_to :conversation,
    class_name: 'FoxYam::Conversation'

  has_one :negotiation,
    through: :inbox,
    class_name: 'FoxYam::Negotiation'

  scope :unclaimed,
    -> { where "#{self.table_name}.conversation_id is null" }

  scope :claimed,
    -> { where "#{self.table_name}.conversation_id is not null" }

  scope :latest_first,
    -> { order "#{self.table_name}.created_at desc"}

  class << self
    def raw_hash_from_email(email)
      { raw_body: email.message.body.to_yaml, raw_envelope: email.envelope.to_yaml }
    end
  end

  def from
    envelope.from
  end

  def update_from_gmail(email)
    update self.class.raw_hash_from_email email
    self
  end

  def body
    YAML.load raw_body
  end

  def envelope
    YAML.load raw_envelope
  end

  def email_addresses
    from.map { |f| "#{f.mailbox}@#{f.host}" }
  end

  def from_presentation
    f = from.first
    "#{f.name} (#{f.mailbox}@#{f.host})"
  end

  def from_presentation_google_style
    f = from.first
    return f.name unless f.name.blank?
    return "#{f.mailbox}@#{f.host}"
  end

  def subject
    envelope.subject
  end

  def rich_content
    return "" if plain?
    rich_section.strip.split("\r\n\r\n").tail.join("\r\n\r\n")
  end

  def rich_section
    body_chunks.select { |chunk| _rich_content? chunk }.first.to_s
  end

  def plain_content
    return plain_section.strip.split("\r\n\r\n").tail.join("\r\n\r\n") if rich?
    return body_chunks.join('\r\n')
  end

  def plain_section
    body_chunks.select { |chunk| _plain_content? chunk }.first.to_s
  end

  def body_chunks
    body.raw_source.split(/\-\-\w+\-*/).reject(&:blank?)
  end

  def rich?
    body_chunks.any? { |chunk| _rich_content? chunk }
  end

  def plain?
    !rich?
  end

  private
  def _rich_content?(str)
    str.split("\r\n").any? { |s| s =~ /Content-Type: text\/html/ }
  end

  def _plain_content?(str)
    str.split("\r\n").any? { |s| s =~ /Content-Type: text\/plain/ }
  end

end
