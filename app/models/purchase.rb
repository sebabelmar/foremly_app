class Purchase < ActiveRecord::Base
  # Remember to create a migration!
  validates :serial, uniqueness: true
end
