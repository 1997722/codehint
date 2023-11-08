class Post < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  belongs_to :user
  has_many :comments
  has_one_attached :image

  with_options presence: true do
    validates :content
    validates :image
  end
  
  def self.search_by_tag(tag_name)
    if tag_name.present?
      joins(:tags).where(tags: { tag_name: tag_name })
    else
      all
    end
  end
  
  def save_tags(sent_tags)
    new_tags = sent_tags
    old_tags = self.tags.pluck(:tag_name) - sent_tags
  
    old_tags.each do |old|
      tag_to_remove = self.tags.find_by(tag_name: old)
      self.tags.destroy(tag_to_remove) if tag_to_remove
    end
  
    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_tag
    end
  end
end
