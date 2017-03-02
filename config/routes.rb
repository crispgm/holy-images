Rails.application.routes.draw do
  get "index" => "index#index"
  get "upload" => "image#upload"
  get "image/:id" => "image#item"
  post "image/create" => "image#create"
  post "image/like/:id" => "image#like"

  root "index#index"
end
