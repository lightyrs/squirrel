class AddDocumentsCountToClassifications < ActiveRecord::Migration

  def self.up
    add_column :classifications, :documents_count, :integer, :null => false, :default => 0
    Document.counter_culture_fix_counts
  end

  def self.down
    remove_column :classifications, :documents_count
  end
end
