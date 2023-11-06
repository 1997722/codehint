class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :destroy]

  def index
    @tag_list = Tag.all     
    @posts = Post.all
    @post = current_user.posts.new
    @posts = Post.includes(:user).order("created_at DESC")
  end

  def new
    @post = Post.new 
    @posts = Post.all
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tag_name].split(nil)                 
    if @post.save
      @post.save_tags(tag_list)                         
      redirect_back(fallback_location: root_path)
    else      
      render :new       
    end
  end

  def show
    @post_tags = @post.tags         
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to root_path
  end
  
  def destroy
    @post.destroy
    redirect_to root_path
  end

  
  def search
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
  end

  private

  def post_params
    params.require(:post).permit(:content, :image).merge(user_id: current_user.id)
  end 

  def set_post
    @post = Post.find(params[:id])  
  end
end
