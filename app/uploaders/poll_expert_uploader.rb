class PollExpertUploader < BaseImageUploader
  version :small_retina do
    process resize_to_fill: [256, 256]
    process convert: 'jpg'
  end

  version :small, from_version: :small_retina do
    process resize_to_fill: [128, 128]
    process convert: 'jpg'
  end
end