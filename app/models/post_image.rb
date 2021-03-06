class PostImage < ApplicationRecord

  has_one_attached :image #ActiveStoreageに画像を持たせる
  belongs_to :user #ユーザーに属する,1:N の「N」側にあたるモデルに、belongs_to
  has_many :post_comments, dependent: :destroy #has_manyでPostCommentモデルを複数持つことを表す
  has_many :favorites, dependent: :destroy

  #バリデーション
  validates :shop_name, presence: true
  validates :image, presence: true

  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end

  #画像が設定されないときapp/assets/imagesに格納されているno_image.jpgをデフォルト画像としてActiveStorageに格納し、格納した画像を表示
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io:File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
