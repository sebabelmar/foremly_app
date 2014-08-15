require_relative '../lib/bank_statement'

transactions = BankStatement.new.cc_purchases_hash

transactions.each do |transaction|
  Purchase.create(
      serial: transaction[:serial],
      date: transaction[:date],
      ammount: transaction[:ammount],
      vendor: transaction[:vendor],
      transaction_type: transaction[:transaction_type],
      location: transaction[:location],
      card_number: transaction[:card_number]
    )
end