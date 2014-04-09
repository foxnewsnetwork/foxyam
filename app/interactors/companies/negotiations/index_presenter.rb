class Companies::Negotiations::IndexPresenter
  class << self
    def from_company(company)
      new.tap do |i|
        i.company = company
      end
    end
  end
  attr_accessor :company

  def negotiations
    company.negotiations
  end

  def paginate(per: per, page: page)
    self
  end
end