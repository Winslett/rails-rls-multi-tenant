class Team < ApplicationRecord

  has_many :users
  has_many :contacts
  has_many :opportunities

end
