class AudioUploader < CarrierWave::Uploader::Base
  storage :file
  def store_dir
    "#{Settings.store_dir}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    Settings.word.audio.allow_type
  end
end
