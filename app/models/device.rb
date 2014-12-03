class Device < ActiveRecord::Base
  belongs_to :delivery_man

  def self.find_or_create(identifier, delivery_man)
    device = delivery_man.device
    if device
      device.push_identifier = identifier
    else
      device = Device.new(:push_identifier => identifier)
      device.delivery_man = delivery_man
    end    
    device.save
    return device
  end

  # Push notification/GCM to mobile
  # Alert Delivery Man there are new incoming orders
  def alert_new_orders
    data = {
      :code => "NEW_ORDER"
    }
    GCM.send_notification(self.push_identifier, data)
  end

  def login
    self.status = 'online'
    self.save
  end

  def logout
    self.status = 'offline'
    self.save
  end
end
