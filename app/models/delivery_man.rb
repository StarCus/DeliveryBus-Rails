# Status: available, busy
class DeliveryMan < ActiveRecord::Base
  has_many :orders
  has_many :current_orders, -> { where status: "in_progress" }, class_name: 'Order'
  belongs_to :route

  after_touch :refresh_availability

  has_secure_password

  def get_current_orders
    if self.status == "busy"
      current_orders = self.current_orders
    else
      # Total Amount should be less than 20
      current_orders = []
      total_amount = 0

      # Where conditions
      conditions = {
        :status => "pending"
      }

      if self.route
        conditions[:route_id] = self.route.id
      else
        conditions[:route_id] = nil
      end

      orders = Order.where(conditions).order("created_at ASC").each do |order|
        if total_amount + order.amount <= 20
          order.status = "in_progress"
          order.delivery_man = self
          order.save
          current_orders.push(order)
          total_amount += order.amount
        else
          break
        end
      end
    end

    if current_orders.count == 0
      self.update_attributes(:status => "available")
    else
      self.update_attributes(:status => "busy")
    end
    return current_orders
  end

  def refresh_availability
    if current_orders.count == 0
      self.update_attributes(:status => "available")
    else
      self.update_attributes(:status => "busy")
    end
  end

  def as_json(options={})
    json = super.as_json()
    json[:route] = self.route.as_json
    return json
  end

end
