class CreateRequestPapers < ActiveRecord::Migration[6.1]
  def change
    create_table :request_papers do |t|
      t.string :rut
      t.string :address
      t.float :count

      t.timestamps
    end
  end
end
