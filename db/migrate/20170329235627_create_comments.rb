class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :project, foreign_key: true
      t.string :author
      t.string :content

      t.timestamps
    end
  end
end
