class Merchants::Negotiations::Presenter

  attr_accessor :merchant
  def initialize(merchant)
    @merchant = merchant
  end

  def negotiations
    merchant.negotiations
  end
end