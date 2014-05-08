class Integrations::Sessions::UserBase

  attr_accessor :session, :errors
  def initialize
    @session = Capybara::Session.new :selenium
    @errors = ActiveModel::Errors.new self
    session.visit 'http://localhost:3000'
  end

  def clicks(xpath: xpath)
    valid? && _find(xpath).click
  end

  def valid?
    errors.blank?
  end

  private
  def _find(xpath)
    begin
      session.find(:xpath, xpath)
    rescue Capybara::ElementNotFound => e
      errors.add :element_not_found, e.message
    end
  end
end