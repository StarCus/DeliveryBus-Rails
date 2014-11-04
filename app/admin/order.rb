ActiveAdmin.register Order do

  index do 
    column :id
    column :address
    column :route
    column :price
    column :amount
    column :payment_method
    column :status
    column :created_at
    actions
  end

  permit_params :user_id, :price, :amount, :payment_method, :address_id

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  form do |f|
    f.inputs "" do 
      f.input :user
      f.input :delivery_man
      f.input :address
      f.input :price
      f.input :amount
      f.input :payment_method
    end
    f.actions
  end
end
