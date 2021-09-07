class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :municipality
      t.string :grouptype
      t.text :description

      t.timestamps
    end
  end
end
