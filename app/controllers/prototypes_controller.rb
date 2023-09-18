# prototype_controller.rb

class PrototypesController < ApplicationController
  # before_action :authenticate_user!
  before_action :move_to_index, except: [:index, :show ]


  def index
    # 全データを@prototypesインスタンス変数に格納
    @prototypes = Prototype.all
  end

  def new
    # 新規データを@prototypeインスタンス変数に格納
    @prototype = Prototype.new
    # newアクション内でapp\views\prototypes\new.html.erbというビューファイルを表示するための命令
    render 'new'
  end


  def create
    # @prototypeオブジェクトを作成
    @prototype = current_user.prototypes.new(prototype_params)

    if @prototype.save
      # フォーム送信が成功した場合の処理
       redirect_to '/'
   else
      # フォーム送信が失敗した場合の処理：#newアクション内でapp\views\prototypes\new.html.erbビューを表示
       render :new, status: :unprocessable_entity
   end
  end

  def show
    @prototype = Prototype.find(params[:id])
    # コメントデータを取得
    @comment = Comment.new  # コメントオブジェクトを生成するために修正
    @comments = @prototype.comments.includes(:user)
  end


  def edit
    @prototype = Prototype.find(params[:id])
    unless @prototype.user == current_user
      redirect_to root_path
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      # フォーム送信が成功した場合の処理
      redirect_to '/'
    else
      # フォーム送信が失敗した場合の処理：#editアクション内でapp\views\prototypes\edit.html.erbビューを表示
      render :edit
    end
  end


  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.user == current_user
      @prototype.destroy
      redirect_to root_path
    else
      # ログインユーザー以外の場合
      redirect_to root_path
    end
  end


private

  def prototype_user_params
    params.require(:prototype).permit(:email, :encrypted_password, :name, :profile, :occupation, :position, :image)
  end
  
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image )
  end


  def move_to_index
    unless user_signed_in?
      redirect_to root_path # ルートヘルパーを使用してトップページへリダイレクト
    end
  end

end