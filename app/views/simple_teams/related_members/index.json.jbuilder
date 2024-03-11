json.array! @members do |member|
  json.id member.email
  json.label "#{member.email}"
  json.value "#{member.email}"
end
