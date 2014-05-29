class EmailInteractor

  attr_accessor :email, :inbox
  def initialize(email: email, inbox: inbox)
    @email = email
    @inbox = inbox
  end

  def store_email
    _bccs && _ccs && _from && _email_attachments
  end

  def message_id
    email.message.message_id
  end

  private
  def _email_record
    @email_record ||= inbox.emails.find_by_external_id(message_id) || 
      inbox.emails.create(external_id: message_id).update_from_gmail(email)
  end

  def _envelope
    @envelope ||= _email_record.envelope.tap { |e| e.update!(subject: email.envelope.subject) }
  end

  def _from
    _envelope.from_address.update email_presentation: _from_email.name,
      email_address: "#{_from_email.mailbox}@#{_from_email.host}"
  end

  def _from_email
    email.envelope.from.first
  end

  def _ccs
    return true if _cc_emails.blank?
    _cc_emails.map do |cc|
      _envelope.cc_addresses.find_or_create_by! origin_type: :cc,
        email_presentation: cc.name,
        email_address: "#{cc.mailbox}@#{cc.host}"
    end
  end

  def _cc_emails
    email.envelope.cc
  end

  def _bccs
    return true if _bcc_emails.blank?
    _bcc_emails.map do |cc|
      _envelope.cc_addresses.find_or_create_by! origin_type: :bcc,
        email_presentation: cc.name,
        email_address: "#{cc.mailbox}@#{cc.host}"
    end
  end

  def _bcc_emails
    email.envelope.bcc
  end
  
  def _email_attachments
    email.message.attachments.map do |attachment|
      _email_record.attached_files.create! _to_attachment_params attachment
    end
  end

  def _to_attachment_params(attachment)
    {
      the_file: _image_file(attachment)
    }
  end

  def _image_file(attachment)
    _tempfile_for(attachment).tap do |f|
      f.write attachment.read
    end
  end

  def _tempfile_for(attachment)
    Paperclip::Tempfile.new([attachment.filename, _get_extension(attachment.filename)], encoding: 'ascii-8bit')
  end

  def _get_extension(str)
    ".#{str.split('.').last}"
  end
end