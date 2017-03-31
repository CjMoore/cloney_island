class CreateUserRolesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :user_roles_tables do |t|
      t.references :user, foreign_key: true
      t.references :role, foreign_key: true
    end
  end
end
