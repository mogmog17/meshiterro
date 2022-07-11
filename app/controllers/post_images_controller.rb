class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end
  
  # 投稿データの保存
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id #@post_image(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーの ID)に指定することで投稿データに、今ログイン中のユーザーの ID を持たせる
    @post_image.save #PostImageモデルへ保存
    redirect_to post_images_path #投稿一覧画面へリダイレクト
  end

  def index
  end

  def show
  end
  
  # 投稿データのストロングパラメータ
  private
  
  def post_image_params #フォームで入力されたデータが、投稿データとして許可されているパラメータかどうかチェックしてる
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end
end