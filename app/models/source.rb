# == Schema Information
#
# Table name: sources
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  url         :string           not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Source < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { scope: :url }
  validates :url,  presence: true

  attr_accessible :name, :url, :description
end
