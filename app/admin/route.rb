ActiveAdmin.register Route do

  index do 
    column :name
    column "Image" do |event|
      image_tag(event.image.url(:thumb), :height => '100')
    end
    actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
        # f.input :category_id , :as => :select , :collection => Category.all
  form(:html => { :multipart => true }) do |f|
    f.inputs "Route" do
      f.input :name
      f.input :image, :as => :file#, :hint => f.template.image_tag(f.object.image.url) 
    end
    f.actions
  end

end
