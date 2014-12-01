class Device < ActiveRecord::Base
  belongs_to :delivery_man

  def self.find_or_create(identifier, delivery_man)
    device = Device.find_by_push_identifier(identifier)
    unless device
      device = Device.new(:push_identifier => identifier)
    end
    device.status = 'online'
    device.delivery_man = delivery_man
    device.save
    return device
  end

end
