Rails.application.routes.draw do
  get "index" => "index#index"
  get "upload" => "image#upload"
  post "image/create" => "image#create"
  post "image/like/:id" => "image#like"

  root "index#index"
end
