# Status: "in_progress", "pending", "done"
class Order < ActiveRecord::Base

  #validates :amount, presence: true

  before_save :set_required_fields
  after_create :assign

  belongs_to :user
  belongs_to :delivery_man, touch: true
  belongs_to :address
  belongs_to :route

  def set_required_fields
    # When new order created, it only set address
    # We need to set route here
    self.amount ||= 0
    self.price ||= 0

    if address
      route = address.route
      self.route = route if route
    end
  end

  # Assign this order to an available delivery man
  def assign
    conditions = {
      :status => "available"
    }

    if self.route
      conditions[:route_id] = self.route.id
    else 
      conditions[:route_id] = nil
    end

    delivery_man = DeliveryMan.where(conditions).first
    if delivery_man
      delivery_man.update_attributes(:status => "busy")
      self.delivery_man = delivery_man
      self.status = "in_progress"
      self.save

      delivery_man.alert_new_orders
    else
      self.status = "pending"
      self.save
    end
  end

  def address_name
    if self.address
      return self.address.name
    else
      return ""
    end
  end

  def as_json(options={})
    json = super.as_json()
    json[:restaurant] = self.user.name
    json[:address] = self.address_name
    return json
  end

end
