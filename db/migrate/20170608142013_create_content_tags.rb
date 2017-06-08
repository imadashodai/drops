class CreateContentTags < ActiveRecord::Migration[5.0]
  def change
    create_table :content_tags do |t|
      t.integer :content_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
