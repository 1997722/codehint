class PostsController < ApplicationController
  def index
    @tag_list = Tag.all     
    @posts = Post.all
    @post = current_user.posts.new
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
    @post = Post.find(params[:id])  
    @post_tags = @post.tags         
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
end
