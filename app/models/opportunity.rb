class Opportunity < ApplicationRecord

  acts_as_tenant :team

  belongs_to :user

  has_many :opportunity_contacts
  has_many :contacts, through: :opportunity_contacts

end
