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
#

class Negotiation < ActiveRecord::Base
  belongs_to :merchant
  has_many :offers

  has_many :sell_offers,
    -> { sells },
    class_name: 'Offer'

  has_many :buy_offers,
    -> { buys },
    class_name: 'Offer'

  has_many :buyers,
    -> { select(:company_name).distinct },
    through: :buy_offers,
    source: :company,
    class_name: 'Company'

  has_many :sellers,
    -> { select('companies.id', :company_name).distinct },
    through: :sell_offers,
    source: :company,
    class_name: 'Company'

  has_many :materials,
    through: :sell_offers,
    class_name: 'Conversations::Material'

  has_many :quantities,
    through: :sell_offers,
    class_name: 'Conversations::Quantity'

  has_many :packing_weights,
    through: :sell_offers,
    class_name: 'Conversations::PackingWeight'

  scope :completed,
    -> { where "#{self.table_name}.completed_at < ?", DateTime.now }

  scope :incomplete,
    -> { where "#{self.table_name}.completed_at is null" }

  def complete!
    update completed_at: DateTime.now
  end

  
end
