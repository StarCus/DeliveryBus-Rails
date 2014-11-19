class AddRouteImageToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :image, :string
  end
end
