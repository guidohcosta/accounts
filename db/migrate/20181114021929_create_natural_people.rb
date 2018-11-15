class CreateNaturalPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :natural_people do |t|
      t.string :cpf
      t.string :fullname
      t.date :birthdate

      t.timestamps
    end
  end
end
