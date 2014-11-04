class AddRouteAndAddressToOrdersAndDeliveryMen < ActiveRecord::Migration
  def change
    add_column :orders, :address_id, :integer
    add_column :orders, :route_id, :integer

    add_column :delivery_men, :route_id, :integer
  end
end
