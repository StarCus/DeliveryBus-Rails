# Status: "in_progress", "pending", "done"
class Order < ActiveRecord::Base

  after_create :assign

  belongs_to :user
  belongs_to :delivery_man
  belongs_to :address
  belongs_to :route

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
end
