class Contact < ApplicationRecord

  acts_as_tenant :team

  belongs_to :opportunity, optional: true

end
