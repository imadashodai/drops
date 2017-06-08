class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :is_active, null: false
      t.datetime :opened_at, null: false

      t.timestamps
    end
  end
end
