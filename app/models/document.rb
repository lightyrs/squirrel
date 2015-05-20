# == Schema Information
#
# Table name: documents
#
#  id                  :integer          not null, primary key
#  url                 :string           not null
#  title               :string
#  description         :text
#  best_image_url      :string
#  favicon_url         :string
#  author              :string
#  keywords            :string           is an Array
#  content_type_header :string
#  charset             :string
#  og_type             :string
#  body                :text
#  body_html           :text
#  classification_id   :integer          not null
#  created_at          :datetime
#  updated_at          :datetime
#

class Document < ActiveRecord::Base

  belongs_to :classification, required: true

  validates :url,  presence: true, uniqueness: { scope: :classification_id }
  validates :body, presence: true

  before_validation :fetch_document, on: :create

  attr_accessible :url, :title, :description, :best_image_url, :favicon_url,
                  :author, :keywords, :content_type_header, :charset,
                  :og_type, :classification_id, :body, :body_html

  update_index 'documents#document', :self

  private

  def fetch_document
    FetchDocument.run!(document: self)
  end
end
