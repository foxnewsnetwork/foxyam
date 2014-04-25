class FoxYam::Usability::CompanyMailer < ActionMailer::Base

  def sell_offer(presenter)
    @presenter = presenter
    delivery_options = { 
      user_name: presenter.seller_email,
      password: presenter.seller_password 
    }
    attachments['goats.jpg'] = File.read Rails.root.join('public', 'gotes.jpg')
    mail to: presenter.merchant_email, 
      from: presenter.seller_email, 
      subject: presenter.subject,
      delivery_method_options: delivery_options
  end
end
