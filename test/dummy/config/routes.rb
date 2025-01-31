Rails.application.routes.draw do
  devise_for :users
  resources :organizations
  mount SimpleTeams::Engine => "/"

  root to: "organizations#index"
end
