class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :address
      t.float :price, null: false, default: 0
      t.integer :amount, null: false, default: 0
      t.belongs_to :user, null: false
      t.belongs_to :delivery_man
      t.string :payment_method, null: false, default: "cash"
      t.string :status

      t.timestamps
    end
  end
end
