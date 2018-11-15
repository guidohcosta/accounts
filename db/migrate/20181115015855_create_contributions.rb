class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.string :code
      t.references :head, foreign_key: true
      t.integer :amount
      t.boolean :reversed

      t.timestamps
    end
    add_index :contributions, :code, unique: true
  end
end
