class Negotiations::EmailCompanies::Presenter

  attr_accessor :interactor
  delegate :merchant,
    to: :interactor
  delegate :company_name,
    to: :company
  def initialize(interactor)
    @interactor = interactor
  end

  def companies
    interactor.companies.limit 15
  end

  def company
    @company ||= merchant.companies.find_by_company_name interactor.company_name
  end


  def company?
    company.present?
  end

  def company_description
    "You have never done business with #{company.company_name}"
  end
end