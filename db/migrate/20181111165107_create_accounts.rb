class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :balance
      t.string :name
      t.date :creation

      t.timestamps
    end
  end
end
