class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.integer :parent_id
      t.string :parent_type
      t.references :head, foreign_key: true

      t.timestamps
    end
  end
end
