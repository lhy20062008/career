class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :labeled_type
      t.integer :labeled_id
      t.string :name

      t.timestamps
    end
  end
end
