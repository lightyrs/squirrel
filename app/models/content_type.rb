# == Schema Information
#
# Table name: content_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class ContentType < ActiveRecord::Base

  has_many :classifications
  has_many :documents, through: :classifications

  validates :name, presence: true, uniqueness: true

  attr_accessible :name
end
