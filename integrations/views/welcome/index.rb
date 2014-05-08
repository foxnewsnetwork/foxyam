class Integrations::Views::Welcome::Index < Integrations::Views::Base

  attr_accessor :user
  def initialize(user)
    @user = user
  end

  def click_buy_materials_button
    user.clicks xpath: '//*[@id="welcome-index"]/div[2]/div[1]/a'
  end
end