class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :first_name, null: false, default: ""
      t.string :last_name
      t.string :suffix
      t.string :email
      t.string :phone
      t.timestamps
    end
  end
end
