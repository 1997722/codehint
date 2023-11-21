class UsersController < ApplicationController
  before_action :set_user, only: [:likes, :show]
  
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    # 自分の投稿だけを取得するための修正
    @posts = @user.posts.or(Post.where(user_id: current_user.id)) # 自分の投稿 or 特定ユーザーの投稿
    @like_posts = @user.likes.includes(:post)
  end

  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
