require 'rest-client'
require 'base64'

def fetch_imagga(response_image)
  tf = Tempfile.open
  tf.write(response_image.body)

  image_results = ""
  File.open(tf.path) do |images_file|
    classes = get_classes(images_file)
    yield(classes)
  end
  # Do something with the image results
  tf.unlink
end

def get_classes(images_file)
  api_key = 'acc_45953c9c7f20ebe'
  api_secret = 'd2108864cd8ef3f33208300d92e3ce05'

  auth = 'Basic ' + Base64.strict_encode64( "#{api_key}:#{api_secret}" ).chomp
  response = RestClient.post "https://api.imagga.com/v2/uploads", { :image => images_file }, { :Authorization => auth }
  response = JSON.parse(response)
  p "Image uploda ID:", response["result"]["upload_id"]
  image_upload_id = response["result"]["upload_id"]

  auth = 'Basic ' + Base64.strict_encode64( "#{api_key}:#{api_secret}" ).chomp
  response = RestClient.get "https://api.imagga.com/v2/tags?image_upload_id=#{image_upload_id}", { :Authorization => auth }
  response = JSON.parse(response)
  classes = response["result"]["tags"].map { |tag| tag["tag"]["en"]}
  p "Recognition result:", classes
  classes
end