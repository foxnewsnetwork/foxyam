namespace :gmail do
  desc "Retreive from Gmail and update the negotiation"
  task fetch: :environment do
    puts EmailAccountInteractor.new.store_unread_emails
  end
end