#Credit cards numbers hardcoded.
cc_numbers = [
  "425907XXXXXX0417",
  "425907XXXXXX0429",
  "425907XXXXXX6457",
  "425907XXXXXX2783",
  "425907XXXXXX0403",
  "425907XXXXXX6382",
  "425907XXXXXX0292"
]

#User/Cardholders
i = 0
cc_numbers.each do |cc_number|
  User.create(
    name: "user_#{i}",
    password: "123",
    phone_number: "19282740117",
    email: "user_#{i}@foremly.com",
    card_number: cc_numbers[i]
    )
  i += 1
end
