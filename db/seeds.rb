# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
FoxYam::EmailAccount.preload
u = FoxYam::User.create! email: 'gumi@vocalo.id', password: 'asdf123', password_confirmation: 'asdf123'
FoxYam::Merchant.all.map do |merchant|
  merchant.hires u
end