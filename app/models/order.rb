class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  enum status: { waiting_for_payment: 0, payment_confirmed: 1, in_production: 2, preparing_for_shipping: 3, shipped: 4 }

  def status_i18n
    I18n.t("enums.order.status.#{self.status}")
  end

  def payment_method_i18n
    return "" if payment_method.nil?
    I18n.t("enums.order.payment_method.#{payment_method}")
  end

  def self.payment_methods_i18n
    {
      credit_card: I18n.t('enums.order.payment_method.credit_card'),
      transfer: I18n.t('enums.order.payment_method.transfer')
    }
  end

  def total_payment
    order_details.sum { |detail| detail.price * detail.amount }
  end

  def shipping_cost
    self[:shipping_cost] || 800
  end

  def total_amount
    total_payment + shipping_cost
  end

  def total_items
    order_details.sum(:amount)
  end
end
