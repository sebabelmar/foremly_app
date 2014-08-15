require "ofx"
require "chronic"

FILE = "data/Checking4.ofx"

class BankStatement

  attr_reader :transactions, :cc_purchase
  def initialize
    @transactions = all_transactions
    @cc_purchase = []
  end

  def print_cc_purchases
    clean
    memo_corrector
    cc_purchases_to_print
  end

  def cc_purchases_hash
    clean
    memo_corrector
    miracle = []
    @cc_purchase.each do |transaction|
        year = transaction.posted_at.year.to_s
        memo = transaction.memo.split(" ")
        date = (Chronic.parse(transaction.memo.split(" ")[3]+"/#{year}")).to_s
        ammount = (transaction.amount_in_pennies.to_f / 100.00 * (-1.00)).to_s
        serial = "#{date.to_s.delete(' ')[0..9]}#{ammount.to_s}"

        miracle << {
        serial: serial,
        date: date,
        ammount: ammount,
        vendor: transaction.name,
        transaction_type: memo[2],
        location: "#{memo[4]} #{memo[5]}",
        card_number: memo[6],
        }
    end
    miracle
  end

  def id_uniqueness?
    clean
    @cc_purchase.map(&:object_id).inject({}){|h, e| h[e] = h[e].to_i + 1; h}.values.uniq.length == 1
  end

  def card_holders
    clean
    memo_corrector
    cc_holders = []
    @cc_purchase.each do |transaction|
      cc_holders << transaction.memo.split(" ")[6]
    end
    cc_holders.uniq
  end

  private
  def all_transactions
    OFX(FILE) do
      # p account
      # p account.balance
      return account.transactions
    end
  end

  def clean
    @transactions.each do |transaction|
      if transaction.type == :pos && transaction.memo != "CHECK"
        @cc_purchase << transaction
      end
    end
  end

  def memo_corrector
    @cc_purchase.each do |transaction|
      memo_arr = transaction.memo.split(" ")
      if memo_arr.length == 10 && memo_arr.last == "122105278DA"
        memo_arr.pop
      elsif memo_arr.length == 10
          city = "#{memo_arr.fetch(4)}_#{memo_arr.fetch(5)}"
          memo_arr.delete_at(4)
          memo_arr.delete_at(4)
          memo_arr.insert(4, city)
         transaction.memo = memo_arr.join(' ')
      end
    end
  end

  def cc_purchases_to_print
    @cc_purchase.each do |transaction|
        puts "*"*30
        p transaction.type
        year = transaction.posted_at.year.to_s
        p Chronic.parse(transaction.memo.split(" ")[3]+"/#{year}")
        p transaction.amount_in_pennies.to_f / 100.00 * (-1.00)
        p transaction.name
        memo = transaction.memo.split(" ")
        p memo[2]
        p "#{memo[4]} #{memo[5]}"
        p memo[6]
    end
  end
end

