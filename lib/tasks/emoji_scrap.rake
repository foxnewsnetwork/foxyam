namespace :emoji do

  task scrap: :environment do
    Emoji::ScrapInteractor.scrap_between! 1..846
  end
end