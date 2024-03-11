json.extract! invitation, :id, :email_address, :created_at, :updated_at
json.url team_invitation_url(team, invitation, format: :json)
