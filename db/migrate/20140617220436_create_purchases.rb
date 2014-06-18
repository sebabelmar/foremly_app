bunclass CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name

    end
  end
end