Rails.application.routes.draw do
  get "index" => "index#index"

  get "upload" => "image#upload"
  get "image/:id" => "image#item"
  post "image/create" => "image#create"
  post "image/like/:id" => "image#like"

  get "user/new" => "user#new"
  get "user/sign-in" => "user#sign_in"
  post "user/create" => "user#create"

  root "index#index"
end
