class FoxYam::Usability::CompanyMailer < ActionMailer::Base
  default from: "cheapcthulhu4u@gmail.com"

  def sell_offer(presenter)
    @presenter = presenter
    attachments['goats.jpg'] = File.read Rails.root.join('public', 'gotes.jpg')
    mail to: presenter.merchant_email, subject: presenter.subject
  end
end
