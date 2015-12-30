json.array!(@agent_payments) do |agent_payment|
  json.extract! agent_payment, :id, :pb_member_id, :amount, :user_id, :note
  json.url agent_payment_url(agent_payment, format: :json)
end
