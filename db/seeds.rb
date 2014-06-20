cc_numbres = [
  "425907XXXXXX0417",
  "425907XXXXXX0429",
  "425907XXXXXX6457",
  "425907XXXXXX2783",
  "425907XXXXXX0403",
  "425907XXXXXX6382",
  "425907XXXXXX0292"
]

names = [
"seba",
"mike",
"laura",
"wally",
"pepe",
"lola",
"cristian"
]
i = 0
cc_numbres.each do |cc_number|
  User.create(
    name: names[i],
    password: "123",
    phone_number: "19282740117",
    email: "#{names[i]}@foremly.com",
    cardholder: cc_numbres[i]
    )
  i += 1
end
