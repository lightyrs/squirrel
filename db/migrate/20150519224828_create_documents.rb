class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string     :url,                         null: false
      t.string     :title
      t.text       :description
      t.string     :best_image_url
      t.string     :author
      t.string     :keywords, array: true
      t.string     :content_type_header
      t.string     :charset
      t.string     :og_type
      t.references :classification, index: true, null: false
      t.timestamps
    end
    add_index :documents, :keywords, using: 'gin'
    add_index :documents, [:url, :classification_id], unique: true
  end
end
