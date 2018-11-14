class AddPolymorphicFieldsToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :person_id, :integer
    add_column :accounts, :person_type, :string
    add_index :accounts, [:person_type, :person_id]
  end
end
