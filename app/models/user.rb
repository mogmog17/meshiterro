class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image #ActiveStorageでプロフィール画像を保存できるように設定

  #1人のユーザーがたくさん投稿写真を持ってる、Userが削除された時に、そのUserが投稿したPostImageが全て削除される
  #ほとんどの場合「has_many」には「dependent: :destroy」を付けて実装
  #1:N の「1」側にあたるモデルに、has_many
  has_many :post_images, dependent: :destroy

  #Userのデータが削除されたとき、そのUserが投稿したコメントデータも一緒に削除される
  has_many :post_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy

  def get_profile_image(width, height) #get_profile_imageメソッドに引数を設定
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed #et_profile_imageメソッドの引数に設定した値に画像のサイズを変換する
  end

end
