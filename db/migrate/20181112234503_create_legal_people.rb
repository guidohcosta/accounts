class CreateLegalPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :legal_people do |t|
      t.string :cnpj
      t.string :corporate_name
      t.string :trading_name

      t.timestamps
    end
  end
end
