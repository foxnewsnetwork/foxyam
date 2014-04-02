class EmailAccountInteractor
  def store_unread_emails
    accounts.map do |account|
      EmailInboxInteractor.new(account).store_unread_emails
    end
  end

  def accounts
    EmailAccount.all
  end
end