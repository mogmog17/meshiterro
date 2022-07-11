class PostImage < ApplicationRecord

  has_one_attached :image #ActiveStoreageに画像を持たせる
  belongs_to :user #ユーザーに属する,1:N の「N」側にあたるモデルに、belongs_to

end
