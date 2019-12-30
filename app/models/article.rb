class Article < ApplicationRecord
  include QuillEditor
  mount_uploader :cover, ImageUploader
  has_many :attachments, as: :attachmentable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true
  has_many :labels, as: :labeled, dependent: :destroy
  accepts_nested_attributes_for :labels, allow_destroy: true
  before_save :save_images

  def quill_field
    :body
  end
end
