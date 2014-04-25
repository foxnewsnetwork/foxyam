# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
FoxYam::EmailAccount.preload
gumi = FoxYam::User.create! email: 'gumi@vocalo.id', 
  password: 'asdf123', 
  password_confirmation: 'asdf123'
cthulhu = FoxYam::User.create! email: 'cthulhu@ryl.eh', 
  password: 'asdf123', 
  password_confirmation: 'asdf123'
nyarlathotep = FoxYam::User.create! email: 'nyarlathotep@crawlingcha.os', 
  password: 'asdf123', 
  password_confirmation: 'asdf123'

merchant = FoxYam::Merchant.find_by_name! 'Gumi Merchant Company'
seller = FoxYam::Merchant.find_by_name! 'Cthulhu Product Sales Company'
buyer = FoxYam::Merchant.find_by_name! 'Nyarlathotep Purchasing Company'

merchant.hires gumi
seller.hires cthulhu
buyer.hires nyarlathotep