class Address < ApplicationRecord
  belongs_to :customers
  validates :customer, presence: true
end
