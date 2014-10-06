class Venda < ActiveRecord::Base
  validates :purchaser_name, presence: true
  validates :item_price, presence: true
  validates :purchase_count, presence: true
end
