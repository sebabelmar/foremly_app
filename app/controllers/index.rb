get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/update' do

  `rake db:seed_transactions  `

  redirect '/manager'
end

get '/manager' do
  @users = User.all

  erb :manager
end

get '/user_transactions_check/:card_number' do
  cardholder_transactions = Purchase.where(card_number: params[:card_number])

  cardholder_transactions_order_date = cardholder_transactions.reverse!
  @cardholder_transactions = cardholder_transactions_order_date
  erb :user_transactions_check
end

post '/sign_in_cardholder'  do
  @email = params[:email]
  @password = params[:password]

  @user = User.find_by_email(params[:email])

  redirect "/cardholder/#{@user.id}"
end


get '/cardholder/:id' do
  @user = User.find(params[:id])
  user_card_number = @user.card_number

  @user_transactions = Purchase.where(card_number: user_card_number, posted: nil ).reverse

  erb :cardholder
end

post "/transaction/:serial" do
  purchase = Purchase.find_by_serial(params[:serial])

  purchase.job_number = params[:job_number]
  purchase.accounting_code = params[:acct_code]

  user = User.find_by_card_number(purchase.card_number)

  if purchase.save
    purchase.posted = true
    purchase.save
    redirect "/cardholder/#{user.id}"
  else
    redirect "/cardholder/#{purchase.serial}"
    # fix this to an error redirect
  end
end