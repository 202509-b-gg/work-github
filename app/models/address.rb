class Address < ApplicationRecord
  belongs_to :customer
  validates :customer, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :recipient_name, presence: true
  

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + recipient_name
  end
  
end
