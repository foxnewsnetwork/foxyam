namespace :usability do

  desc "Fetches the merchant, buyer, and seller accounts and sends a round of emails"
  task setup: :environment do
    FoxYam::Usability::SetupInteractor.new.setup!
  end
end