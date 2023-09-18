class Comment < ApplicationRecord
  
  # Commentモデルにおいて「カラムが空では保存できない」というバリデーション設定
  validates :content, presence: true

  belongs_to :prototype
  belongs_to :user
end
