class CreateFounds < ActiveRecord::Migration[6.1]
  def change
    create_table :founds do |t|
      t.date :date
      t.float :amount
      t.string :number
      t.string :rut
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
