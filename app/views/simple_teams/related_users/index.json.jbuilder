json.array! @users do |user|
  json.id user.email
  json.label "#{user.email}"
  json.value "#{user.email}"
end
