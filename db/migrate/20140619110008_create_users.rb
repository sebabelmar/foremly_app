class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :phone_number
      t.string :email
      t.string :card_number

      t.timestamps
    end
  end
end
