class User < ActiveRecord::Base
  # Remember to create a migration!
  validates :cardholder, uniqueness: true
end
