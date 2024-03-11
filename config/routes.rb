SimpleTeams::Engine.routes.draw do

  # Team Resources
  resources :teams do
    resources :memberships, :only => [:edit, :update, :destroy]
    resources :invitations, :only => [:new, :create, :edit, :update, :destroy] do
      post "resend", :on => :member
    end
    resource :leave_team, :only => [:destroy]
  end

  # Team Invitations
  get "accept_team_invitation/:id", :as => "accept_team_invitation", to: "teams/accept_invitations#new"
  post "accept_team_invitation/:id", to: "teams/accept_invitations#create"

  # Related Users Autocomplete
  resources :related_users, :only => [:index] do
    get "select2", :on => :collection
  end

end
