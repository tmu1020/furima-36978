class ShippingAddress < ApplicationRecord
  belongs_to_active_hash :prefecture
  belongs_to :purchase_record
end
