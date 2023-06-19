class Sale < ApplicationRecord
  belongs_to :company
  validates :purchase_name, presence: true
  validates :item_price, presence: true
  validates :purchase_count, presence: true
  validates :merchant_name, presence: true
end
