class Negotiations::Buyers::ContactsInteractor < InteractorBase
  class MalformatEmail < StandardError; end
  Fields = [
    :to,
    :cc,
    :bcc
  ]
  attr_accessor :company, :attributes
  attr_hash_accessor *Fields
  def initialize(company=nil)
    @company = company
  end

  def contacts!
    [_to_contacts, _cc_contacts, _bcc_contacts].reject(&:blank?).flatten
  end

  private
  def _cc_contacts
    _create_contacts _array_of_contact_hash cc if cc.present?
  end
  def _bcc_contacts
    _create_contacts _array_of_contact_hash bcc if bcc.present?
  end
  def _array_of_contact_hash(string)
    _to_hash_of_email_name_array _split_to_google_style string
  end
  def _to_contacts
    _create_contacts _array_of_contact_hash to
  end
  def _create_contacts(hashes)
    hashes.map do |hash|
      _contacts_proxy.find_or_create_by hash
    end.map(&:consider_promote_to_sales!)
  end

  def _contacts_proxy
    company.contacts
  end

  def _split_to_google_style(email_str)
    email_str.split(",").reject(&:blank?).map(&:strip)
  end

  def _to_hash_of_email_name_array(emails)
    emails.map do |email|
      { name: _grab_name_part(email), email: _grab_email_part!(email) }
    end
  end

  def _grab_email_part!(email)
    e = _grab_email_part(email)
    raise MalformatEmail, email if e.blank?
    return e
  end

  def _grab_name_part(email)
    s = _not_empty_parantheses _not_email email
    s.strip
  end

  def _not_empty_parantheses(email)
    email.gsub /\(\s*\)/, ""
  end

  def _not_email(email)
    email.gsub _grab_email_part(email), ""
  end

  def _grab_email_part(email)
    _stuff_in_final_parantheses(email).to_s[Devise.email_regexp].to_s.gsub(/^\(/, '').gsub(/\)$/, '')
  end

  def _stuff_in_final_parantheses(email)
    email.to_s.strip[/\(?[\w\d\-_@\.]+\)?$/]
  end
end