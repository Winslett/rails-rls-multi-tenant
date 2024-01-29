class CreateOpportunities < ActiveRecord::Migration[7.1]
  def change
    create_table :opportunities do |t|

      t.string :name
      t.string :status

      t.references :team, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
