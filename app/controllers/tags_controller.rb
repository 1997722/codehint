class TagsController < ApplicationController
  def index
    @tags = Tag.joins(:post_tags).group('tags.id').order('COUNT(post_tags.tag_id) DESC')
  end
end
