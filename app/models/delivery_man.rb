# Status: available, busy
class DeliveryMan < ActiveRecord::Base
  has_many :orders
  has_many :current_orders, -> { where status: "in_progress" }, class_name: 'Order'

  has_secure_password

  def get_current_orders
    if self.status == "busy"
      self.current_orders
    else
      # TODO Fetch orders from order list
    end
  end

end
