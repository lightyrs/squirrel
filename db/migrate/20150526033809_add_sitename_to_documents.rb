class AddSitenameToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :sitename, :string
  end
end
