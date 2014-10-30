class DeliveryMan < ActiveRecord::Base
  has_many :orders
end
