class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :serial
      t.date :date
      t.string :ammount
      t.string :vendor
      t.string :transaction_type
      t.string :location
      t.string :cardholder

      t.string :job_number
      t.string :accounting_code
      t.boolean :posted
      #put a defaul value and change the completeness of manager table

      t.timestamps
    end
  end
end