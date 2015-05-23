# == Schema Information
#
# Table name: classifications
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  description     :text
#  content_type_id :integer          not null
#  created_at      :datetime
#  updated_at      :datetime
#

class Classification < ActiveRecord::Base

  belongs_to :content_type
  has_many   :documents

  validates :name, presence: true, uniqueness: { scope: :content_type_id }

  attr_accessible :name, :description, :content_type_id

  def content_type_name
    content_type.name
  end
end
