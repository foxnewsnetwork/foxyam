class Merchants::Negotiations::Presenter

  attr_accessor :merchant
  delegate :negotiations,
    to: :merchant
  def initialize(merchant)
    @merchant = merchant
  end

end