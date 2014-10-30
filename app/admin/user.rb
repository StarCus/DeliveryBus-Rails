ActiveAdmin.register User do

  filter :email
  filter :restaurant_name
  filter :location

  index do 
    column :email
    column :restaurant_name
    column :location
    actions
  end

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
    f.inputs "User Details" do 
      f.input :email
      f.input :restaurant_name
      f.input :location
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
