ActiveAdmin.register Article do
  sidebar '历史', :partial => "layouts/version", :only => :show, class: 'history'
  permit_params :author, :title, :body, :summary, :cover,
    labels_attributes: [
      :id, :_destroy, :name
    ],
    attachments_attributes: [
      :id, :_destroy, :file
    ]

  index do
    selectable_column
    id_column
    column :author
    column :title do |article|
      article.title.truncate(10)
    end
    column :cover do |article|
      image_tag article.cover.url.to_s
    end
    column :created_at
    actions
  end

  filter :author
  filter :title
  filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :title
      f.input :author
      f.input :cover, hint: image_tag(resource.cover.url.to_s)
      f.input :summary
      f.input :body, as: :quill_editor, input_html: 
        {data: {options: Article.quill_options}}
    end
    f.inputs '标签' do
      f.has_many :labels, allow_destroy: true do |l|
        l.input :name
      end
    end
    f.inputs '附件' do
      f.has_many :attachments, allow_destroy: true do |a|
        a.input :file, hint: a.object.name
      end
    end
    f.actions
  end

  show do
    attributes_table :title, :author do
      row :cover do
        image_tag resource.cover.url.to_s
      end
      rows :summary
      row :body do
        raw resource.body
      end
      row :labels do
        resource.labels.pluck(:name).join(" ")
      end
      row :attachments do
        resource.attachments.map do |attachment|
          link_to attachment.name, attachment.file.url, download: attachment.name
        end
      end
      rows :created_at, :updated_at
    end
  end

end
