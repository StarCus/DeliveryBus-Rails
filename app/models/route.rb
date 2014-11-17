class Route < ActiveRecord::Base
  has_many :addresses  
  has_many :orders

  mount_uploader :image, RouteImageUploader

  def as_json(options={:except => [:image]})
    json = super.as_json()
    json[:url] = self.image.url
    return json
  end
end
