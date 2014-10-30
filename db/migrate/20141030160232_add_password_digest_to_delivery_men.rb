class AddPasswordDigestToDeliveryMen < ActiveRecord::Migration
  def change
    add_column :delivery_men, :password_digest, :string
  end
end
