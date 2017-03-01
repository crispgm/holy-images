Rails.application.routes.draw do
  get "index" => "index#index"
  get "upload" => "image#upload"
  post "image/create" => "image#create"

  root "index#index"
end
