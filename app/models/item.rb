class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  has_one_attached :item_image

  validates :name,presence:true
  validates :introduction,presence:true
  validates :price,presence:true

  def get_item_image
  if item_image.attached?
    item_image
  else
    'no_image.jpg'
  end
  end

  def add_tax_price
    (self.price * 1.10).round
  end

    def self.ransackable_attributes(auth_object = nil)
    # nameは検索OKとする
    %w[name]
  end

  def self.ransackable_associations(auth_object = nil)
    # 関連先のモデルを検索する必要がなければ空の配列を返す
    []
  end

end
