class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  # has_one    :purchase_record

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :prefecture

  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :item_name
    validates :description
    validates :price
  end
  # 選択が「---」の時は保存不可
  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :shipping_day_id
    validates :prefecture_id
  end
  # 半角数字かつ、整数かつ、¥300〜¥9,999,999の間で保存可能
  validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' }
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
end
