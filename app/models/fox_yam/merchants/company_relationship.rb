module FoxYam::Merchants::CompanyRelationship

  def find_by_company_name(company_name)
    find_by_permalink FoxYam::Company.to_permalink(company_name, proxy_association.owner)
  end

  def find_by_permalink_but_create_by_company_name!(company_name)
    find_by_company_name(company_name) || create!(company_name: company_name)
  end

  def find_by_default_contactable!(email: email, company_name: company_name)
    find_by_permalink_but_create_by_company_name!(company_name).tap do |c|
      c.update company_email: email
      c.contacts.find_or_create_by email: email, role: :overseer
    end
  end

end