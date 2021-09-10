class CreateFounds < ActiveRecord::Migration[6.1]
  def change
    create_table :founds do |t|
      t.datetime :date_receipt
      t.float :amount
      t.string :receipt_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
