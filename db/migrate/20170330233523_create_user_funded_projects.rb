class CreateUserFundedProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :user_funded_projects do |t|
      t.integer :amount
      t.string :credit_card_number
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
