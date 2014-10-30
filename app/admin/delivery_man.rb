ActiveAdmin.register DeliveryMan do

  index do 
    column :phone_number
    column :name
  end

  form do |f|
    f.inputs "Delivery Man Details" do 
      f.input :phone_number
      f.input :name
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end


  permit_params :phone_number, :name, :password, :password_confirmation
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


end
