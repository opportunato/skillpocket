class UserBannerUploader < BaseImageUploader
  version :normal do
    process resize_to_fit: [1500, 250]
    process convert: 'jpg'
  end
end