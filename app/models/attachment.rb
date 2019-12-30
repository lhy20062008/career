class Attachment < ApplicationRecord
  include Attachmentable
  belongs_to :attachmentable, -> {with_deleted}, polymorphic: true, optional: true
  validates_presence_of :file
  mount_uploader :file, FileUploader
end
