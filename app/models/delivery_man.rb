# Status: available, busy
class DeliveryMan < ActiveRecord::Base
  has_many :orders
  has_many :current_orders, -> { where status: "in_progress" }, class_name: 'Order'
  belongs_to :route

  has_secure_password

  def get_current_orders
    if self.status == "busy"
      current_orders = self.current_orders
    else
      current_orders = Order.where(:status => "pending").order("created_at ASC").limit(10).each do |order|
        order.status = "in_progress"
        order.delivery_man = self
        order.save
      end
    end

    if current_orders.count == 0
      self.update_attributes(:status => "available")
    else
      self.update_attributes(:status => "busy")
    end
    return current_orders
  end

  def as_json(options={})
    json = super.as_json()
    json[:route] = self.route.as_json
    return json
  end

end
