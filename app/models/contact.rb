class Contact < ApplicationRecord

  belongs_to :team
  belongs_to :opportunity, optional: true

end
