class UserPhotoUploader < BaseImageUploader
  version :small do
    process resize_to_fill: [128, 128]
    process convert: 'jpg'
  end
end