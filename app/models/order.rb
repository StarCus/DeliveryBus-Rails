# Status: "in_progress", "pending", "done"
class Order < ActiveRecord::Base

  before_save :set_required_fields
  after_create :assign

  belongs_to :user
  belongs_to :delivery_man
  belongs_to :address
  belongs_to :route

  def set_required_fields
    # When new order created, it only set address
    # We need to set route here
    if address
      route = address.route
      self.route = route if route
    end
  end

  # Assign this order to an available delivery man
  def assign
    delivery_man = DeliveryMan.find_by_status("available")
    if delivery_man
      delivery_man.update_attributes(:status => "busy")
      self.delivery_man = delivery_man
      self.status = "in_progress"
      self.save
      # Push to notify delivery man
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
