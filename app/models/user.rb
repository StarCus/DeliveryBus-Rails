class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_one :delivery_man

  before_create :set_required_fields

  # def as_json(options = {})
  #   json = super.as_json()
  #   return json
  # end

  # For ActiveAdmin only
  def name
    self.restaurant_name
  end

  private

  def set_required_fields
    self.restaurant_name ||= self.email
  end
end
