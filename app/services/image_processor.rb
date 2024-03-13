# app/services/image_processor.rb
class ImageProcessor
  # Processes the image and returns the processed image file
  def self.process_and_attach_image(uploaded_image, dimensions)
    # Process the image to desired dimensions using MiniMagick
    image = MiniMagick::Image.open(uploaded_image.tempfile.path)
    image.resize(dimensions) # This resizes while maintaining aspect ratio
    
    # Save the processed image to a temporary file
    temp_file = Tempfile.new(["processed", ".jpg"])
    image.write(temp_file.path)
    temp_file.rewind
    
    return temp_file # Return the processed file
  end
end

