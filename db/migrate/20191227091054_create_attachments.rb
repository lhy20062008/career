class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :file
      t.integer :size
      t.string :ext
      t.string :attachmentable_type
      t.integer :attachmentable_id

      t.timestamps
    end
  end
end
