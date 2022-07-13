class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  # 投稿データの保存
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id #@post_image(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーの ID)に指定することで投稿データに、今ログイン中のユーザーの ID を持たせる
    @post_image.save #PostImageモデルへ保存
    if @post_image.save
      redirect_to post_images_path #投稿一覧画面へリダイレクト
    else
      render :new
    end
  end

  def index
    @post_images = PostImage.page(params[:page])
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new #コメント投稿するためのインスタンス変数を定義
  end

  def destroy
    @post_image = PostImage.find(params[:id]) #削除するPostImageデータ（レコード）を1件取得
    @post_image.destroy #データ（レコード）を削除
    redirect_to '/post_images' #投稿一覧画面へリダイレクト
  end

  # 投稿データのストロングパラメータ
  private

  def post_image_params #フォームで入力されたデータが、投稿データとして許可されているパラメータかどうかチェックしてる
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end
end
