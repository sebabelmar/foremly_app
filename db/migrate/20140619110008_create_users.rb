class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :phone_number
      t.string :email
      t.string :cardholder

      t.timestamps
    end
  end
end
