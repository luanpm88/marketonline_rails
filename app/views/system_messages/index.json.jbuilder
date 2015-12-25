json.array!(@system_messages) do |system_message|
  json.extract! system_message, :id, :code, :name, :content
  json.url system_message_url(system_message, format: :json)
end
