class Address < ApplicationRecord
  belongs_to :customer
  validates :customer, presence: true

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + recipient_name
  end
  
end
