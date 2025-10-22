class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: { unable_to_making: 0, waiting_for_making: 1, in_making: 2, complete_made: 3 }

  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :price, presence: true
  validates :amount, presence: true
  validates :making_status, presence: true

  def subtotal
    price * amount
  end

end
