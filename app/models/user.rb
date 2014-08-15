class User < ActiveRecord::Base
  # Remember to create a migration!
  validates :card_number, uniqueness: true
end
