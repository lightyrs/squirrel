class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.string     :name,                      null: false
      t.text       :description
      t.references :content_type, index: true, null: false
      t.timestamps
    end
    add_index :classifications, [:name, :content_type_id], unique: true
  end
end
