# Status: available, busy
class DeliveryMan < ActiveRecord::Base
  has_many :orders

  has_secure_password
end
