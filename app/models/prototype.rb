class Prototype < ApplicationRecord

  
  # Prototypeモデルにおいて「カラムが空では保存できない」というバリデーション設定
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  
  has_many :comments, dependent: :destroy

  belongs_to :user
  
  has_one_attached :image
  validate :image_presence

  private

  def image_presence
    if !image.attached?
      errors.add(:image)
    end
  end
end