class FoxYam::Usability::CompanyMailer < ActionMailer::Base

  def sell_offer(presenter)
    @presenter = presenter
    delivery_options = { 
      user_name: presenter.smtp_user,
      password: presenter.smtp_password 
    }
    attachments['goats.jpg'] = File.read Rails.root.join('public', 'gotes.jpg')
    mail to: presenter.merchant_email, 
      from: presenter.smtp_user, 
      subject: presenter.subject,
      delivery_method_options: delivery_options
  end
end
