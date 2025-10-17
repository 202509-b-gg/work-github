class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  def self.payment_methods_i18n
    {
      credit_card: I18n.t('enums.order.payment_method.credit_card'),
      transfer: I18n.t('enums.order.payment_method.transfer')
    }
  end

  def total_payment
    order_details.sum { |detail| detail.price * detail.quantity }
  end

  def shipping_cost
    shipping_fee || 800
  end

  def total_amount
    total_payment + shipping_cost
  end

end
