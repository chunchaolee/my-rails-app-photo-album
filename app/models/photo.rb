class Photo < ApplicationRecord
  # 掛載上傳器
  mount_uploader :file_location, PhotoImageUploader
  validates_presence_of :title, :date, :description, :file_location
end
