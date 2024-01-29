class CreateOpportunityContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :opportunity_contacts do |t|

      t.references :opportunity, foreign_key: true
      t.references :contact, foreign_key: true

      t.references :team, foreign_key: true

      t.timestamps

    end
  end
end
