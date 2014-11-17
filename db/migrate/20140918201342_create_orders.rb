class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :address
      t.float :price
      t.integer :amount
      t.belongs_to :user, null: false
      t.belongs_to :delivery_man
      t.string :payment_method, null: false, default: "cash"
      t.string :status

      t.timestamps
    end
  end
end
