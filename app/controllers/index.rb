get '/' do
  # Look in app/views/index.erb
  @cardholders = Holder.all

  erb :index
end

get '/card/:cardnumber' do
   api = Foremly::Transaction.new("http://localhost:", 1)

   @trans = api.cardholder_transactions(params[:cardnumber])

  erb :transactions
end
