class Address < ActiveRecord::Base
  belongs_to :route
  has_many :orders
end
