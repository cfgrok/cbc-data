json.array!(@observers) do |observer|
  json.extract! observer, :id, :first_name, :last_name, :email
  json.url observer_url(observer, format: :json)
end
