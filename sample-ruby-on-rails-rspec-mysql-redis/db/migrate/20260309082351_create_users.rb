class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :age, null: false
      t.index :email, unique: true

      t.timestamps
    end
  end
end
