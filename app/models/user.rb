class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :restaurant
  has_one :delivery_man

  after_create :set_required_fields

  def as_json(options = {})
    json = super.as_json()
    if self.restaurant
      json[:restaurant] = self.restaurant.as_json
    else 
      json[:delivery_man] = self.delivery_man.as_json
    end
    return json
  end

  private

  def set_required_fields
    self.username = self.email
    if role == "restaurant"
      restaurant = Restaurant.new
      restaurant.user = self
      restaurant.save
    else
      self.role = "delivery_man"
      delivery_man = DeliveryMan.new
      delivery_man.user = self
      delivery_man.save
    end
  end
end
