class CreateDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :details do |t|
      t.string :first_name, null: true
      t.string :last_name, null: true
      t.integer :age, null: true
      t.string :gender, null: true

      t.timestamps
    end
  end
end
