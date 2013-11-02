class Article < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }

  def tag_list
    self.tags.map(&:name).join ", "
  end

  def tag_list= (tags_string)
    tag_names = tags_string.split(',').map { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.map do |name|
      Tag.find_or_create_by(name: name)
    end
    self.tags = new_or_found_tags
  end
end
