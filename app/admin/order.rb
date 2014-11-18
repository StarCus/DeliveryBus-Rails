# encoding: UTF-8
ActiveAdmin.register Order do

  index do 
    column :id
    column :address
    column :route
    column :price
    column :amount
    column :payment_method
    column :status
    column :created_at, :sortable => :created_at do |obj|
      obj.created_at.localtime.strftime("%B %d, %Y %H:%M")
    end
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
      f.input :user, :label => "餐厅"
      f.input :delivery_man, :label => "外卖员"
      f.input :address, :label => "地址"
      f.input :price, :label => "价钱"
      f.input :amount, :label => "数量"
      f.input :payment_method, :label => "支付方式", :as => :select, :collection => [["在线支付", "online"], ["现金支付", "cash"]]
      # f.input :payment_method
    end
    f.actions
  end
end
