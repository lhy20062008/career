class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  acts_as_paranoid
  has_paper_trail on: [:update], ignore: [
    :created_at, :updated_at, :deleted_at,
    :current_sign_in_at, :last_sign_in_at, :sign_in_count
  ]
end