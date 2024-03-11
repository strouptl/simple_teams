SimpleTeams::Engine.routes.draw do

  # Team Resources
  resources :teams do
    resources :memberships, :only => [:edit, :update, :destroy]
    resources :invitations, :only => [:new, :create, :edit, :update, :destroy] do
      post "resend", :on => :member
    end
    resource :leave_team, :only => [:destroy]
  end

  # Autocomplete
  resources :related_members, :only => [:index] do
    get "select2", :on => :collection
  end

  # Team Invitations
  get "accept_team_invitation/:id", :as => "accept_team_invitation", to: "accept_invitations#new"
  post "accept_team_invitation/:id", to: "accept_invitations#create"

end
