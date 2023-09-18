## routes.rb

Rails.application.routes.draw do
  # Devise gemを使用してユーザー認証関連のルートを定義
  devise_for :users

  # ルートの設定
  root to: "prototypes#index"

  # プロトタイプのCRUDルートをresourcesで一括設定
    resources :prototypes do
      resources :comments, only: :create
    end

    resources :users, only: :show
  end


