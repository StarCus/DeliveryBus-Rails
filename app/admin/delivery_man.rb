# encoding: UTF-8
ActiveAdmin.register DeliveryMan do

  index do 
    column :phone_number
    column :name
    column :status, :sortable => :status do |man|
      if man.status == "available"
        tag_name = "空闲"
        tag_type = :ok
      else
        tag_name = "忙碌"
        tag_type = :warning
      end
      status_tag(tag_name, tag_type)
    end
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
