module ControllerMacros
  def login_merchant
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Factories::User.mock
      merchant = Factories::Merchant.mock
      merchant.hires user
      sign_in user
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Factories::User.mock
      sign_in user
    end
  end
end