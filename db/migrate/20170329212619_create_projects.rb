class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.integer :total
      t.datetime :time
      t.string :image_url
      t.string :slug 

      t.timestamps
    end
  end
end
