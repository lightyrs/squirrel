class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string     :name, null: false
      t.string     :url, null: false
      t.text       :description
      t.timestamps
    end
    add_index :sources, [:name, :url], unique: true
  end
end
