class UsersController < ApplicationController
  before_action :set_user, only: [:likes, :show]
  
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    # ログインユーザーが選択したユーザーの投稿のみを取得する
    if current_user == @user
      @posts = @user.posts
    else
      @posts = @user.posts.where(user_id: @user.id)
    end

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
