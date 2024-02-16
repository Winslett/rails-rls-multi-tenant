class User < ApplicationRecord

  acts_as_tenant :team

  belongs_to :team
  has_many :opportunities

end
