Rails.application.routes.draw do
  scope "(:locale)", locale: /en|zh-CN/ do
    get "index" => "index#index"

    get "upload" => "image#upload"
    get "image/:id" => "image#item"
    post "image/create" => "image#create"
    post "image/like/:id" => "image#like"
    post "image/comment/:id" => "image#comment"

    get "explore" => "image#explore"
    get "explore/digest" => "image#digest"

    get "user/new" => "user#new"
    get "user/sign-in" => "user#sign_in"
    post "user/locale" => "user#locale"
    post "user/create" => "user#create"
    post "user/login" => "user#login"
    post "user/logout" => "user#logout"
    get "u/:name" => "user#info"
    get "u/:name/invitation" => "user#invite"

    root "index#index"
  end

  namespace :api do
    namespace :v1, constraints: { format: 'json' } do
      get "images" => "images#index"
      get "images/:id" => "images#show"
      post "images" => "images#create"
    end
  end
end
