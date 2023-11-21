class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:edit, :show, :update, :destroy]
  # before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id]) if params[:tag_id].present?

    @post = current_user.posts.new if user_signed_in?

    @posts = Post.includes(:user).order('created_at DESC').page(params[:page]).per(12)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tag_name].split(nil)
    if @post.save
      @post.save_tags(tag_list)
      flash[:notice] = '投稿が成功しました。'
    else
      flash[:alert] = '投稿に失敗しました。'
    end
    redirect_to root_path
  end

  def show
    @post_tags = @post.tags
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
  end

  def update
    tag_list = params[:post][:tag_name].split(',')
  
    if params[:post][:content].present? || params[:post][:tag_name].present?
      if @post.update(content: params[:post][:content])
        if params[:post][:tag_name].present?
          @post.tags.destroy_all
          @post.save_tags(tag_list)
        end
        flash[:notice] = '投稿を更新しました。'
        redirect_to root_path
      else
        flash[:alert] = '更新に失敗しました。'
        render :edit
      end
    else
      flash[:alert] = '更新できる要素が見つかりませんでした。'
      render :edit
    end
  end
  
  def destroy
    # 投稿に関連する全てのいいねを削除
    @post.likes.destroy_all
    # 投稿に関連する全てのコメントを削除
    @post.comments.destroy_all
    # 投稿を削除
    @post.destroy
    redirect_to root_path
  end

  def search
    @tag_name = params[:tag_name]
    @tag = Tag.find_by(tag_name: @tag_name)
    @posts = @tag.present? ? @tag.posts : []
  end

  private
  
  def post_params
    params.require(:post).permit(:content, :image, :tag_name).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # def move_to_index
  # unless user_signed_in?
  # redirect_to action: :index
  # end
  # end
end
