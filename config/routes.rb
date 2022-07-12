Rails.application.routes.draw do

  devise_for :users

  #topページに遷移
  root to: "homes#top"

  #homes/aboutページに遷移
  get 'homes/about' => 'homes#about', as:'about'

  #resourcesメソッドでルーティングを一括して自動生成
  #only の後に配列で記述されている"new","index","show"のアクション以外は、ルーティングが行われない(新規投稿,一覧,詳細機能,削除しか使わないため)
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :des]
  end

  resources :users, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
