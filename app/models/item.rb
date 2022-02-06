class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one    :purchase_record

  # Active Hashとのアソシエーション
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :shipping_day
  belongs_to :prefecture

  # Active Storageとのアソシエーション
  has_one_attached :image

  with_options presence: true do
    validates :user_id
    validates :image
    validates :item_name
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :shipping_day_id
    validates :prefecture_id
    # 300円以上、9,999,999円以下、半角数字で保存可能
    validates :price, numericality: {
      greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999
    }
  end

  # 選択が「--」の時は保存不可
  with_options numericality: { other_than: 0 , message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :shipping_day_id
    validates :prefecture_id
  end
end
