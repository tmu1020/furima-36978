class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :token, :post_code, :prefecture_id, :city,
                :address, :building_name, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :post_code
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number
  end
  # 郵便番号ハイフンありの指定
  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  # 電話番号10〜11桁、半角数字、整数の指定
  validates :phone_number, length: { minimum: 10, message: 'is too short' }
  validates :phone_number, length: { maximum: 11, message: 'is too long' }
  validates :phone_number, numericality: { only_integer: true, message: 'is invalid. Input only number' }

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)

    ShippingAddress.create(
      post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
      building_name: building_name, phone_number: phone_number, purchase_record_id: purchase_record.id
    )
  end
end
