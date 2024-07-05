module ApplicationHelper
  def avatar_options
    Dir.glob("#{Rails.root}/app/assets/images/*.png").map do |path|
      [File.basename(path, ".png").humanize, File.basename(path)]
    end
  end
end
