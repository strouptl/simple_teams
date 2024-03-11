json.results do
  json.array! @members do |member|
    json.id member.email
    json.text "#{member.email}"
  end
end
