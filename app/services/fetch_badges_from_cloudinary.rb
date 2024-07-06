class FetchBadgesFromCloudinary
  def self.call
    new.call
  end

  def call
    fetch_badges
  end

  private

  # Fetches badge data from Cloudinary
  def fetch_badges
    begin
      # Fetch resources from Cloudinary with the specified prefix and include context for metadata
      result = Cloudinary::Api.resources(type: :upload, prefix: 'development/science-lab/badges/', context: true)

      # Debugging information for API response
      Rails.logger.debug("Cloudinary API response: #{result}")

        # Ensure we have context in the resources
        result['resources'].each do |resource|
          Rails.logger.debug("Resource: #{resource['public_id']}, Context: #{resource['context']}")
        end

      # Map the Cloudinary resources to our badge structure
      result['resources'].map do |resource|
        # Extract title and description from the metadata (context)
        context = resource['context'] && resource['context']['custom']
        title = context['caption']
        description = context['alt']
        {
          title: title,
          description: description,
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
