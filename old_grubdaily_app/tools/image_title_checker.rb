class ImageTitleChecker
  attr_reader :recipes, :image_filenames

  def initialize
    @recipes = Recipe.where(published: true)
    @image_filenames = image_filenames
  end

  def check
    mismatched_recipe_titles = []
    recipe_images = recipes.map(&:image)

    recipe_images.each do |image|
      unless image_filenames.include?(image)
        mismatched_recipe_titles << image
      end
    end

    puts "Found #{mismatched_recipe_titles.count} mismatched titles:\n"
    puts mismatched_recipe_titles
  end

  private

  def image_filenames
    all_entries = Dir.entries("app/assets/images")
    jpgs = all_entries.select{ |entry| entry =~ /.jpg/ }
    jpgs.map{ |filename| filename.gsub(".jpg", "") }
  end
end
