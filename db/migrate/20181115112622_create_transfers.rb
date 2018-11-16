class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.references :from, polymorphic: true
      t.integer :to, foreign_key: true
      t.integer :amount
      t.boolean :reversed

      t.timestamps
    end
  end
end
