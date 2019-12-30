class Label < ApplicationRecord
  belongs_to :labeled, -> {with_deleted}, polymorphic: true, optional: true
  validates_uniqueness_of :name, scope: [:labeled_id, :labeled_type]
end
