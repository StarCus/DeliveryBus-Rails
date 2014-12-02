class Device < ActiveRecord::Base
  belongs_to :delivery_man

  def self.find_or_create(identifier, delivery_man)
    device = Device.find_by_push_identifier(identifier)
    unless device
      device = Device.new(:push_identifier => identifier)
    end    
    device.delivery_man = delivery_man
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
    puts "Send push notification"
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
