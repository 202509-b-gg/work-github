class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: { unable_to_making: 0, waiting_for_making: 1, in_making: 2, complete_made: 3 }

  def subtotal
    price * amount
  end

end
