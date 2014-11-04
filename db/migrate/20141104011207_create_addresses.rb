class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.belongs_to :route
      t.timestamps
    end
  end
end
