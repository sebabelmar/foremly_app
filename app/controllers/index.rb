get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/update' do

  api = Foremly::Transaction.new("http://localhost:", 1)

  all_transactions = api.all_transactions

  @collection = JSON.parse(all_transactions)

  @collection.each do |transaction|
    transaction = transaction.values.first
    Purchase.create(
        serial: transaction["serial"],
        date: transaction["date"],
        ammount: transaction["ammount"],
        vendor: transaction["vendor"],
        transaction_type: transaction["transaction_type"],
        location: transaction["location"],
        cardholder: transaction["cardholder"]
      )
  end
  redirect '/manager'
end

get '/manager' do
  @users = User.all

  erb :manager
end

get '/user_transactions_check/:cardholder' do
  cardholder_transactions = Purchase.where(cardholder: params[:cardholder])

  cardholder_transactions_order_date = cardholder_transactions.reverse!
  @cardholder_transactions = cardholder_transactions_order_date
  erb :user_transactions_check
end
