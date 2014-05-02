# == Schema Information
#
# Table name: negotiations
#
#  id               :integer          not null, primary key
#  merchant_id      :integer
#  deleted_at       :datetime
#  dead_at          :datetime
#  finalized_at     :datetime
#  completed_at     :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  public_at        :datetime
#  negotiation_type :string(255)
#

class FoxYam::Negotiation < ActiveRecord::Base
  NegotiationTypes = [
    'merchant_is_selling',
    'merchant_is_buying'
  ].freeze
  acts_as_paranoid
  belongs_to :merchant,
    class_name: 'FoxYam::Merchant'

  has_one :merchant_company,
    through: :merchant,
    source: :company,
    class_name: 'FoxYam::Company'

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

  has_many :merchant_default_offers,
    through: :merchant_company,
    source: :offers,
    class_name: 'FoxYam::Offer'

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
    through: :offers,
    class_name: 'FoxYam::Conversations::Material'

  has_many :quantities,
    through: :offers,
    class_name: 'FoxYam::Conversations::Quantity'

  has_many :packing_weights,
    through: :offers,
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

  scope :available_for,
    -> (merchant) { where("#{self.table_name}.merchant_id = ? or #{self.table_name}.public_at is not null", merchant.id) }

  scope :publicly_available,
    -> { where "#{self.table_name}.public_at < ?", DateTime.now }

  scope :exclusively_private,
    -> { where "#{self.table_name}.public_at is null" }

  scope :sale_type,
    -> { where "#{self.table_name}.negotiation_type = ?", 'merchant_is_selling' }

  scope :buy_type,
    -> { where "#{self.table_name}.negotiation_type = ?", 'merchant_is_buying' }

  scope :yet_untyped,
    -> { where "#{self.table_name}.negotiation_type is null" }

  def complete!
    update completed_at: DateTime.now
  end

  def public?
    public_at.present? && public_at < DateTime.now
  end

  def sale_type?
    'merchant_is_selling' == negotiation_type
  end

  def buy_type?
    'merchant_is_buying' == negotiation_type
  end

  def merchant_default_offer
    merchant_default_offers.find_by_negotiation_id id
  end
end
