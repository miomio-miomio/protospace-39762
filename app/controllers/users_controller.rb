class UsersController < ApplicationController
  def show
    # ユーザーを取得
    @user = User.find(params[:id]) 

    # ユーザーの名前を取得
    @name = @user.name 

    # ユーザーが投稿したプロトタイプを取得
    @prototypes = @user.prototypes 
  end
end
