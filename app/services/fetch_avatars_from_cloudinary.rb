class FetchAvatarsFromCloudinary
  def self.call
    new.call
  end

  def call
    fetch_avatars
  end

  private

  def fetch_avatars
    begin
      result = Cloudinary::Api.resources(type: :upload, prefix: 'development/science-lab/avatars/', context: true)

      result['resources'].each do |resource|
        Rails.logger.debug("Resource: #{resource['public_id']}, Context: #{resource['context']}")
      end

      result['resources'].map do |resource|
        {
          image_url: resource['secure_url']
        }
      end
    rescue CloudinaryException => e
      Rails.logger.error("Cloudinary API error: #{e.message}")
      []
    end
  end
end
