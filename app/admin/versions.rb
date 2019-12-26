ActiveAdmin.register PaperTrail::Version do
  menu label: "修改日志"
  actions :show, :index
  index title: '修改日志' do
    id_column
    column '对象id', :item_id
    column '对象类型', :item_type
    column '事件', :event
    column '操作者', :whodunnit do |v|
      if v.whodunnit.to_s.start_with?('0')
        AdminUser.with_deleted.find_by_id(v.whodunnit[1..-1].to_i).try(:name)
      elsif v.whodunnit.to_s.start_with?('1')
        User.with_deleted.find_by_id(v.whodunnit[1..-1].to_i).try(:nickname)
      else
        '系统'
      end
    end
    column '修改字段', :changeset, class: 'change-fields' do |v|
      v.changeset.keys.join(",")
    end
    column '时间', :created_at
    actions
  end

  filter :created_at, label: '日期'

  show do
    attributes_table :id do
      row '对象id', :item_id do |v|
        v.item_id
      end
      row '对象类型', :item_type do |v|
        v.item_type
      end
      row '事件', :event do |v|
        v.event
      end
      row '操作者', :whodunnit do |v|
        if v.whodunnit.to_s.start_with?('0')
          AdminUser.with_deleted.find_by_id(v.whodunnit[1..-1].to_i).try(:name)
        elsif v.whodunnit.to_s.start_with?('1')
          User.with_deleted.find_by_id(v.whodunnit[1..-1].to_i).try(:nickname)
        else
          '系统'
        end
      end
      row '修改内容', :changeset do |v|
        raw v.changeset.map{|field, values| "#{field} FROM #{values[0]} TO #{values[1]}"}.join("<br />")
      end
      row '时间', :created_at do |v|
        v.created_at
      end
    end
  end
end
