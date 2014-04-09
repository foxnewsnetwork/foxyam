module SessionHelper
  def current_merchant
    current_merchants.try(:first)
  end

  def current_merchants
    current_user.try(:merchants)
  end
end