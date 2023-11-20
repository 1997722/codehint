class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    followed_user = User.find(params[:id])
    current_user.follow(followed_user)
    redirect_to followed_user
  end

  def destroy
    relationship = current_user.active_relationships.find_by(followed_id: @user.id)
    relationship.destroy if relationship

    respond_to do |format|
      format.turbo_stream do
          render turbo_stream: [
            turbo_stream.remove("user-#{@user.id}") # フォロー一覧から該当ユーザー情報を削除するTurbo Stream コマンド
          ]
        end
      end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
