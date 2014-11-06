class Route < ActiveRecord::Base
  has_many :addresses  
  has_many :orders

  mount_uploader :image, RouteImageUploader
end
