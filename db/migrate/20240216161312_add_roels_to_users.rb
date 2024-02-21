class AddRoelsToUsers < ActiveRecord::Migration[7.1]
  def change
    create_enum :user_roles, ["salesperson", "salesmanager"]

    change_table :users do |t|
      t.enum :role, enum_type: :user_roles, default: "salesperson", null: false
    end
  end
end
