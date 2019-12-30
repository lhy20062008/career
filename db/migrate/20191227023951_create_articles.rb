class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :summary
      t.text :body
      t.string :author
      t.string :cover
      
      t.timestamps
    end
  end
end
