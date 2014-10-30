class CreateDeliveryMen < ActiveRecord::Migration
  def change
    create_table :delivery_men do |t|
      t.string :name
      t.string :phone_number
      t.timestamps
    end
  end
end
