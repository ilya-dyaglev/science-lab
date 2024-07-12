class FetchProductsFromCloudinary
  def self.call
    new.call
  end

  def call
    fetch_products
  end

  private

  # Fetches element image data from Cloudinary
  def fetch_products
    begin
      # Fetch resources from Cloudinary with the specified prefix and include context for metadata
      result = Cloudinary::Api.resources(type: :upload, prefix: 'development/science-lab/products/images/', context: true)

      # Debugging information for API response
      Rails.logger.debug("Cloudinary API response: #{result}")

      # Map the Cloudinary resources to our element structure
      result['resources'].map do |resource|
        # Extract metadata from the context
        context = resource['context'] && resource['context']['custom']
        {
          symbol: resource['public_id'].split('/').last.split('.').first,
          image_url: resource['secure_url']
        }
      end
    rescue CloudinaryException => e
      # Log any errors encountered during the API call
      Rails.logger.error("Cloudinary API error: #{e.message}")
      []
    end
  end
end
