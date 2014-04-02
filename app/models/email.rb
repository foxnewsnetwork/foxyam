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

class Email < ActiveRecord::Base
  attr_accessor :address, :email

  belongs_to :inbox,
    class_name: 'EmailInbox'

  belongs_to :conversation

  has_one :negotiation,
    through: :inbox
  
  scope :unclaimed,
    -> { where "#{self.table_name}.conversation_id is null" }

  def from
    envelope.from
  end

  def update_from_gmail(email)
    update raw_body: email.message.body.to_yaml,
      raw_envelope: email.envelope.to_yaml
    self
  end

  def body
    YAML.load raw_body
  end

  def envelope
    YAML.load raw_envelope
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
    rich_section.strip.split("\r\n\r\n").tail.join("\r\n\r\n")
  end

  def rich_section
    body_chunks.select { |chunk| _rich_content? chunk }.first.to_s
  end

  def plain_content
    plain_section.strip.split("\r\n\r\n").tail.join("\r\n\r\n")
  end

  def plain_section
    body_chunks.select { |chunk| _plain_content? chunk }.first.to_s
  end

  def body_chunks
    body.raw_source.split(/\-\-\w+\-*/).reject(&:blank?)
  end

  private
  def _rich_content?(str)
    str.split("\r\n").any? { |s| s =~ /Content-Type: text\/html/ }
  end

  def _plain_content?(str)
    str.split("\r\n").any? { |s| s =~ /Content-Type: text\/plain/ }
  end

end
