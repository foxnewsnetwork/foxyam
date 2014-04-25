# == Schema Information
#
# Table name: emails
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  email_inbox_id  :integer
#  external_id     :string(255)
#  raw_envelope    :text
#  plain_content   :text
#  html_content    :text
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

  has_one :envelope,
    class_name: 'FoxYam::Envelope'
  def envelope_with_defaults
    return envelope_without_defaults if envelope_without_defaults.present?
    @envelope ||= FoxYam::Envelope.create! email: self
  end
  alias_method_chain :envelope, :defaults

  has_one :from,
    through: :envelope,
    source: :from_address,
    class_name: 'FoxYam::Envelopes::Origin'

  has_many :cc,
    through: :envelope,
    source: :cc_addresses,
    class_name: 'FoxYam::Envelopes::Origin'    

  has_many :bcc,
    through: :envelope,
    source: :bcc_addresses,
    class_name: 'FoxYam::Envelopes::Origin'    

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

  scope :no_html,
    -> { where "#{self.table_name}.html_content is null" }
  scope :no_text,
    -> { where "#{self.table_name}.plain_content is null" }
  scope :no_content,
    -> { no_text.no_text }
  scope :unclaimed,
    -> { where "#{self.table_name}.conversation_id is null" }

  scope :claimed,
    -> { where "#{self.table_name}.conversation_id is not null" }

  scope :latest_first,
    -> { order "#{self.table_name}.created_at desc"}

  class << self
    def content_hash_from_email(email)
      { 
        plain_content: email.text_part.try(:raw_source),
        html_content: email.html_part.try(:raw_source),
      }
    end
  end

  def update_from_gmail(email)
    update self.class.content_hash_from_email email
    self
  end

  def email_addresses
    [from_address.email_address]
  end

  def from_presentation
    f = from_address
    "#{f.email_presentation} (#{f.email_address})"
  end

  def from_presentation_google_style
    f = from_address
    return f.email_presentation unless f.email_presentation.blank?
    return f.email_address
  end

  def subject
    envelope.subject
  end

  def rich_content
    html_content
  end

  def rich?
    html_content.present?
  end

  def plain?
    plain_content.present?
  end

end
