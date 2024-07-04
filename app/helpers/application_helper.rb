module ApplicationHelper
  def avatar_options
    Dir.glob("#{Rails.root}/app/assets/images/avatars/*.png").map do |path|
      [File.basename(path, ".png").humanize, "avatars/#{File.basename(path)}"]
    end
  end
end
