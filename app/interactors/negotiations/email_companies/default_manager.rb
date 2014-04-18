class Negotiations::EmailCompanies::DefaultManager
  Fields = [ :c ]
  attr_accessor :attributes, :merchant, :email
  attr_hash_accessor *Fields

  def defaults
    { company_name: company_name }
  end
  def company_name
    c || _company_names.first
  end

  private
  def _company_names
    _companies.map(&:company_name).select(&:present?)
  end

  def _companies
    _contacts.map(&:company)
  end

  def _contacts
    merchant.contacts.where email: _email_addresses
  end

  def _email_addresses
    email.from.map do |os|
      os.mailbox + "@" + os.host
    end
  end
end