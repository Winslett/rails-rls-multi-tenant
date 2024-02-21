class Contact < ApplicationRecord

  acts_as_tenant :team

  has_many :opportunity_contacts
  has_many :opportunities, through: :opportunity_contacts

end
