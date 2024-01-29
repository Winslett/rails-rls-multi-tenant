class Opportunity < ApplicationRecord

  belongs_to :team
  belongs_to :user

  has_many :opportunity_contacts
  has_many :contacts, through: :opportunity_contacts

end
