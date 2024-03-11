json.results do
  json.array! @users do |user|
    json.id user.email
    json.text "#{user.email}"
  end
end
