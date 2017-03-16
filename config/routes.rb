Rails.application.routes.draw do
  get "index" => "index#index"

  get "upload" => "image#upload"
  get "image/:id" => "image#item"
  post "image/create" => "image#create"
  post "image/like/:id" => "image#like"

  get "explore" => "image#explore"

  get "user/new" => "user#new"
  get "user/sign-in" => "user#sign_in"
  post "user/create" => "user#create"
  post "user/login" => "user#login"
  post "user/logout" => "user#logout"
  get "u/:name" => "user#info"
  get "u/:name/invitation" => "user#invite"

  root "index#index"
end
