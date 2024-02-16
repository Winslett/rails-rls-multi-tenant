class OpportunityContact < ApplicationRecord

  acts_as_tenant :team

  belongs_to :opportunity
  belongs_to :contact

end
