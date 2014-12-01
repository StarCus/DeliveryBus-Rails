class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :os_name, default: "android"
      t.string :push_identifier, null: false
      t.string :status, default: "offline"
      t.belongs_to :delivery_man
      t.timestamps
    end
  end
end
