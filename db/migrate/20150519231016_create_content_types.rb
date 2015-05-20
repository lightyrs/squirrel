class CreateContentTypes < ActiveRecord::Migration
  def change
    create_table :content_types do |t|
      t.string     :name, null: false
      t.timestamps
    end
    add_index :content_types, :name, unique: true
  end
end
