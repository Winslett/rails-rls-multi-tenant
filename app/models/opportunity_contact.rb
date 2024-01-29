class OpportunityContact < ApplicationRecord

  belongs_to :team

  belongs_to :opportunity
  belongs_to :contact

end
