class Article < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments

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
