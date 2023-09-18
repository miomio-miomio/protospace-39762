# app\controllers\comments_controller.rb

class CommentsController < ApplicationController

  def create
    @prototype = Prototype.find(params[:prototype_id])  # コメントを紐づけるプロトタイプを取得
    @comment = @prototype.comments.build(comment_params)  # プロトタイプに紐づけてコメントを作成

    if @comment.save
      # コメントが保存された場合: プロトタイプの詳細画面にリダイレクトする
      redirect_to prototype_path(@prototype)
    else
      # コメントが保存されなかった場合の処理
      # エラーが発生しても@prototypeを設定する
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user: current_user)  # user_id を current_user から取得
  end
end
