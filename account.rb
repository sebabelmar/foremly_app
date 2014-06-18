#<OFX::Transaction:0x0000010299a748 @amount=#<BigDecimal:1029b1380,'-0.4116E2',18(18)>, @amount_in_pennies=-4116, @fit_id="2014031713", @memo="CHECK CRD PURCHASE 03/16 PRESCOTT VALL AZ 425907XXXXXX0417 304075692296169 ?MCC=5411 122105278DA", @name="WAL-MART #3730", @payee="", @check_number="", @ref_number="", @posted_at=2014-03-17 12:00:00 -0700, @type=:pos, @sic="">

require "ofx"
require "chronic"


OFX("Checking4.qfx") do
  # p account
  # p account.balance
  $bs = account.transactions
end

cc_purchase = []
$bs.each do |transaction|
  if transaction.type == :pos && transaction.memo != "CHECK"
    cc_purchase << transaction
  end
end

# transaction id's uniqueness
transaction_ids = []
cc_purchase.each do |transaction|
  if transaction.type == :pos && transaction.memo != "CHECK"
    transaction_ids << transaction.object_id
  end
end
p transaction_ids.inject({}){|h, e| h[e] = h[e].to_i + 1; h}.values.uniq.length == 1


# memo length check
cc_purchase.each do |transaction|
  memo_arr = transaction.memo.split(" ")
  if memo_arr.length > 9
      city = "#{memo_arr.fetch(4)}_#{memo_arr.fetch(5)}"
      memo_arr.delete_at(4)
      memo_arr.delete_at(4)
      memo_arr.insert(4, city)
     transaction.memo = memo_arr.join(' ')
  end
end

length_check = []
cc_purchase.each do |transaction|
  length_check << transaction.memo.split(" ").length
end
p length_check.inject({}){|h, e| h[e] = h[e].to_i + 1; h}.values.uniq.length == 1


cc_holders = []
cc_purchase.each do |transaction|
  cc_holders << transaction.memo.split(" ")[6]
end

p cc_holders.uniq



cc_purchase.each do |transaction|
    puts "*"*30
    p transaction.type
    year = transaction.posted_at.year.to_s
    p Chronic.parse(transaction.memo.split(" ")[3]+"/#{year}")
    p transaction.amount_in_pennies.to_i/100.00*-1
    p transaction.name
    memo = transaction.memo.split(" ")
    p memo[2]
    p "#{memo[4]} #{memo[5]}"
    p memo[6]
end
