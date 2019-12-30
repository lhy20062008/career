ActiveAdmin.register AdminUser do
  sidebar '历史', :partial => "layouts/version", :only => :show, class: 'history'
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :avatar do |admin_user|
      image_tag admin_user.avatar.url.to_s
    end
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :avatar, hint: image_tag(resource.avatar.url.to_s)
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table :email, :name do
      row :avatar do
        image_tag resource.avatar.url.to_s
      end
      rows :role, :created_at, :updated_at
    end
  end

end
