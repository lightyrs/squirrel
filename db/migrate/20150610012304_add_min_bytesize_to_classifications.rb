class AddMinBytesizeToClassifications < ActiveRecord::Migration
  def change
    add_column :classifications, :min_bytesize, :integer, default: 3000
  end
end
