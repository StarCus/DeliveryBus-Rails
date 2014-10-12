class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :restaurant
  has_one :delivery_man

  after_create :set_required_fields

  private

  def set_required_fields
    if role == "restaurant"
      restaurant = Restaurant.new
      restaurant.user = self
      restaurant.save
    else
      delivery_man = DeliveryMan.new
      delivery_man.user = self
      delivery_man.save
    end
  end
end
