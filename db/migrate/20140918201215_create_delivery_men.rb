class CreateDeliveryMen < ActiveRecord::Migration
  def change
    create_table :delivery_men do |t|
      t.string :name
      t.string :phone_number
      t.belongs_to :user
      t.timestamps
    end
  end
end
