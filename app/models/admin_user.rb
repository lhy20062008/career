class AdminUser < ApplicationRecord
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, ImageUploader
end
