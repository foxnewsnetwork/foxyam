# == Schema Information
#
# Table name: negotiations
#
#  id           :integer          not null, primary key
#  merchant_id  :integer
#  deleted_at   :datetime
#  dead_at      :datetime
#  finalized_at :datetime
#  completed_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  public_at    :datetime
#

class FoxYam::Negotiation < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :merchant,
    class_name: 'FoxYam::Merchant'
  has_many :offers,
    class_name: 'FoxYam::Offer'

  has_many :attachments,
    through: :offers,
    class_name: 'FoxYam::AttachedFile'

  has_one :email_inbox, 
    class_name: 'FoxYam::EmailInbox'
  has_many :email_inboxes,  
    class_name: 'FoxYam::EmailInbox'

  has_many :sell_prices,
    through: :sell_offers,
    source: :latest_price,
    class_name: 'FoxYam::Conversations::Price'

  has_many :buy_prices,
    through: :buy_offers,
    source: :latest_price,
    class_name: 'FoxYam::Conversations::Price'

  has_many :sell_offers,
    -> { sells },
    class_name: 'FoxYam::Offer'

  has_many :buy_offers,
    -> { buys },
    class_name: 'FoxYam::Offer'

  has_many :buyers,
    -> { select('companies.id', :company_name).distinct },
    through: :buy_offers,
    source: :company,
    class_name: 'FoxYam::Company'

  has_many :sellers,
    -> { select('companies.id', :company_name).distinct },
    through: :sell_offers,
    source: :company,
    class_name: 'FoxYam::Company'

  has_many :materials,
    through: :sell_offers,
    class_name: 'FoxYam::Conversations::Material'

  has_many :quantities,
    through: :sell_offers,
    class_name: 'FoxYam::Conversations::Quantity'

  has_many :packing_weights,
    through: :sell_offers,
    class_name: 'FoxYam::Conversations::PackingWeight'

  scope :dead,
    -> { where "#{self.table_name}.dead_at < ?", DateTime.now }

  scope :alive,
    -> { where "#{self.table_name}.dead_at is null" }
    
  scope :completed,
    -> { where "#{self.table_name}.completed_at < ?", DateTime.now }

  scope :incomplete,
    -> { where "#{self.table_name}.completed_at is null" }

  scope :finalized,
    -> { where "#{self.table_name}.finalized_at < ?", DateTime.now }

  scope :unfinalized,
    -> { where "#{self.table_name}.finalized_at is null" }

  scope :publicly_available,
    -> { where "#{self.table_name}.public_at < ?", DateTime.now }

  scope :exclusively_private,
    -> { where "#{self.table_name}.public_at is null" }

  def complete!
    update completed_at: DateTime.now
  end

  
end
