get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/card/:cardnumber' do

   api = Foremly::Transaction.new("http://localhost:", 1)


   trans_to_parse = api.cardholder_transactions(params[:cardnumber])

   @trans = JSON.parse(trans_to_parse)

  erb :transactions
end
