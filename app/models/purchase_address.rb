class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :token, :user_id, :item_id, :post_code, :prefecture_id, :city,
                :address, :building_name, :phone_number, :purchase_record_id

  with_options presence: true do
    validates :token
    validates :post_code
    validates :city
    validates :address
    validates :phone_number
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is too short' }
  validates :phone_number, numericality: { only_integer: true, message: 'is invalid. Input only number' }

  def save
    purchase_record = PurchaseRecord.create( user_id: user_id, item_id: item_id )

    ShippingAddress.create(
      post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
      building_name: building_name, phone_number: phone_number, purchase_record_id: purchase_record.id
    )
  end