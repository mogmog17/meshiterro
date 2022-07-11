class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #1人のユーザーがたくさん投稿写真を持ってる、Userが削除された時に、そのUserが投稿したPostImageが全て削除される
  #ほとんどの場合「has_many」には「dependent: :destroy」を付けて実装
  #1:N の「1」側にあたるモデルに、has_many
  has_many :post_images, dependent: :destroy
  
end
