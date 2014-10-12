class Order < ActiveRecord::Base

  belongs_to :restaurant
  belongs_to :delivery_man

end
